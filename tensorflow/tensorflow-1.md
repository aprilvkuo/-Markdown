---
title: tensorflow 中使用RNN
date: 2017-06-07 17:40:13
tags: [Tensorflow]
categories: [Tensorflow]
---

rnn 输入的是有多个时间点序列
在tensorflow中有用来处理这样数据的［数据交换格式］（ protocol buffer）。虽然也可以用python 或者 Numpy 的array，但是tf.SequenceExample有下面的优点。
优点：

1. easy，可以把数据分成多个TFRecord，每一个含有多个序列样例。而且可以支持Tensorflow的分布式计算
2. reusable，方便别人的resuse
3. Use of Tensorflow data loading pipelines functions ，对于tf.learn等库支持更好。
4. Separation of data preprocessing and model code. 

```Using tf.SequenceExample forces you to separate your data preprocessing and Tensorflow model code. This is good practice, as your model shouldn’t make any assumptions about the input data it gets.``` 可以使你将数据预处理模块 与 模型模块分开。
in practice, you write a little script that converts your data into tf.SequenceExample format and then writes one or more TFRecord files. These TFRecord files are parsed by Tensorflow to become the input to your model:

1. Convert your data into tf.SequenceExample format
2. Write one or more TFRecord files with the serialized data
3. Use tf.TFRecordReader to read examples from the file
4. Parse each example using tf.parse_single_sequence_example (Not in the official docs yet)

Examples:

```
sequences = [[1, 2, 3], [4, 5, 1], [1, 2]]
label_sequences = [[0, 1, 0], [1, 0, 0], [1, 1]]
 
def make_example(sequence, labels):
    # The object we return
    ex = tf.train.SequenceExample()
    # A non-sequential feature of our example
    sequence_length = len(sequence)
    ex.context.feature["length"].int64_list.value.append(sequence_length)
    # Feature lists for the two sequential features of our example
    fl_tokens = ex.feature_lists.feature_list["tokens"]
    fl_labels = ex.feature_lists.feature_list["labels"]
    for token, label in zip(sequence, labels):
        fl_tokens.feature.add().int64_list.value.append(token)
        fl_labels.feature.add().int64_list.value.append(label)
    return ex
 
# Write all examples into a TFRecords file
with tempfile.NamedTemporaryFile() as fp:
    writer = tf.python_io.TFRecordWriter(fp.name)
    for sequence, label_sequence in zip(sequences, label_sequences):
        ex = make_example(sequence, label_sequence)
        writer.write(ex.SerializeToString())
    writer.close()
```

And, to parse an example:

```
# A single serialized example
# (You can read this from a file using TFRecordReader)
ex = make_example([1, 2, 3], [0, 1, 0]).SerializeToString()
 
# Define how to parse the example
context_features = {
    "length": tf.FixedLenFeature([], dtype=tf.int64)
}
sequence_features = {
    "tokens": tf.FixedLenSequenceFeature([], dtype=tf.int64),
    "labels": tf.FixedLenSequenceFeature([], dtype=tf.int64)
}
 
# Parse the example
context_parsed, sequence_parsed = tf.parse_single_sequence_example(
    serialized=ex,
    context_features=context_features,
    sequence_features=sequence_features
)
```

# batching and  padding data
tensorflow rnn 函数对输入数据有要求：tensor的shape 为 ［batchsize ，timesteps ,...］batch大小和时间序列的长度，但是__并不是所有的序列长度相等的__.
最常见的解决方法是用 0-padding，后面添0。
但是当维度差距比较大的时候，需要浪费很多资源去计算0－padding的东西。
理想状态是，每个bath只需要padding batch—max－length 大小的。 在tensorflow 中的解决方法是设置```dynamic_pad=True when calling tf.train.batch the returned batch will be automatically padded with 0s```.
**更方便的可以用tf.PaddingFIFOQueue.**
> 在分类问题中不能出现0类，需要注意。

```
# [0, 1, 2, 3, 4 ,...]
x = tf.range(1, 10, name="x")
 
# A queue that outputs 0,1,2,3,...
range_q = tf.train.range_input_producer(limit=5, shuffle=False)
slice_end = range_q.dequeue()
 
# Slice x to variable length, i.e. [0], [0, 1], [0, 1, 2], ....
y = tf.slice(x, [0], [slice_end], name="y")
 
# Batch the variable length tensor with dynamic padding
batched_data = tf.train.batch(
    tensors=[y],
    batch_size=5,
    dynamic_pad=True,
    name="y_batch"
)
 
# Run the graph
# tf.contrib.learn takes care of starting the queues for us
res = tf.contrib.learn.run_n({"y": batched_data}, n=1, feed_dict=None)
 
# Print the result
print("Batch shape: {}".format(res[0]["y"].shape))
print(res[0]["y"])


Batch shape: (5, 4)
[[0 0 0 0]
 [1 0 0 0]
 [1 2 0 0]
 [1 2 3 0]
 [1 2 3 4]]

```
And, the same with PaddingFIFOQueue

```
# ... Same as above
 
# Creating a new queue
padding_q = tf.PaddingFIFOQueue(
    capacity=10,
    dtypes=tf.int32,
    shapes=[[None]])
 
# Enqueue the examples
enqueue_op = padding_q.enqueue([y])
 
# Add the queue runner to the graph
qr = tf.train.QueueRunner(padding_q, [enqueue_op])
tf.train.add_queue_runner(qr)
 
# Dequeue padded data
batched_data = padding_q.dequeue_many(5)
 
# ... Same as above
```

# RNN VS Dynamic RNN

普通的RNN 有固定的步长，建立了一个static graph。不能训练大于步长的数据。

动态的RNN 解决了这个问题，用了tf.while 动态建立graph。这样graph建立速度更快，而且可以训练不同大小的batch数据。

动态的好！！！

在使用RNN函数时候，已经padded的输入需要把sequence_length参数传给模型。***必需的***
有两个作用： 1. 节省计算时间 2.确保准确率

假设一个batch 有两个examples，其中一个序列长度为13，另一个为20. 序列中的每一个都是128维。 这时候需要把13的序列串padding 到20. dynamic—rnn 函数得到一个tuple（outputs, state）.

这时候存在一个问题，在time step 13 的时候，第一个序列串已经done了，不需要额外的计算，所以，需要把 参数```sequence_length = [13,20]```传入，告诉tensorflow当到time－step ＝ 13 时候就结束。

```
# Create input data
X = np.random.randn(2, 10, 8)
 
# The second example is of length 6 
X[1,6:] = 0
X_lengths = [10, 6]
 
cell = tf.nn.rnn_cell.LSTMCell(num_units=64, state_is_tuple=True)
 
outputs, last_states = tf.nn.dynamic_rnn(
    cell=cell,
    dtype=tf.float64,
    sequence_length=X_lengths,
    inputs=X)
 
result = tf.contrib.learn.run_n(
    {"outputs": outputs, "last_states": last_states},
    n=1,
    feed_dict=None)
 
assert result[0]["outputs"].shape == (2, 10, 64)
 
# Outputs for the second example past past length 6 should be 0
assert (result[0]["outputs"][1,7,:] == np.zeros(cell.output_size)).all()
```

#Bidirectional RNNs
双向的RNN能够充分的利用到上下文信息。
双向RNN也有static 和 dymatic 的区分，和之前的一样，动态的会好。
主要的区分点在：```双向RNN将cell 参数分为前向和后向，同时得到不同的输出和states```

```
X = np.random.randn(2, 10, 8)
 
X[1,6,:] = 0
X_lengths = [10, 6]
 
cell = tf.nn.rnn_cell.LSTMCell(num_units=64, state_is_tuple=True)
 
outputs, states  = tf.nn.bidirectional_dynamic_rnn(
    cell_fw=cell,
    cell_bw=cell,
    dtype=tf.float64,
    sequence_length=X_lengths,
    inputs=X)
 
output_fw, output_bw = outputs
states_fw, states_bw = states

```

# RNN CELLS, WRAPPERS AND MULTI-LAYER RNNS

As of the time of this writing, the basic RNN cells and wrappers are:


1. BasicRNNCell – A vanilla RNN cell.
2. GRUCell – A Gated Recurrent Unit cell.
3. BasicLSTMCell – An LSTM cell based on  Recurrent Neural Network Regularization. No peephole connection or cell clipping.
4. LSTMCell – A more complex LSTM cell that allows for optional peephole connections and cell clipping.
5.MultiRNNCell – A wrapper to combine multiple cells into a multi-layer cell.
6. DropoutWrapper – A wrapper to add dropout to input and/or output connections of a cell.
and the contributed RNN cells and wrappers:

and the contributed RNN cells and wrappers:

1. CoupledInputForgetGateLSTMCell – An extended LSTMCell that has coupled input and forget gates based on LSTM: A Search Space Odyssey.
2. TimeFreqLSTMCell – Time-Frequency LSTM cell based on Modeling Time-Frequency Patterns with LSTM vs. Convolutional Architectures for LVCSR Tasks
3. GridLSTMCell – The cell from Grid Long Short-Term Memory.
4. AttentionCellWrapper – Adds attention to an existing RNN cell, based on Long Short-Term Memory-Networks for Machine Reading.
5. LSTMBlockCell – A faster version of the basic LSTM cell (Note: this one is in lstm_ops.py)

# CALCULATING SEQUENCE LOSS ON PADDED EXAMPLES


通常的语言模型通过预测下个word在句子出现的概率，当所有的序列串长度是相同时候，可以用Tenosrflow的 ``` sequence_loss and sequence_loss_by_example functions (undocumented)``` 来计算交叉熵。

当序列长度是变化的时候，上面的方法不可行，解决方法是创建一个 权值矩阵去“mask out”那些padded的位置。

如果用 ```tf.sign(y)```来创建mask的话，也会把0-class处理掉。 我们也可以用序列长度信息，但是会变得更加复杂。

```
# Batch size
B = 4
# (Maximum) number of time steps in this batch
T = 8
RNN_DIM = 128
NUM_CLASSES = 10
 
# The *acutal* length of the examples
example_len = [1, 2, 3, 8]
 
# The classes of the examples at each step (between 1 and 9, 0 means padding)
y = np.random.randint(1, 10, [B, T])
for i, length in enumerate(example_len):
    y[i, length:] = 0  
     
# The RNN outputs
rnn_outputs = tf.convert_to_tensor(np.random.randn(B, T, RNN_DIM), dtype=tf.float32)
 
# Output layer weights
W = tf.get_variable(
    name="W",
    initializer=tf.random_normal_initializer(),
    shape=[RNN_DIM, NUM_CLASSES])
 
# Calculate logits and probs
# Reshape so we can calculate them all at once
rnn_outputs_flat = tf.reshape(rnn_outputs, [-1, RNN_DIM])
logits_flat = tf.batch_matmul(rnn_outputs_flat, W)
probs_flat = tf.nn.softmax(logits_flat)
 
# Calculate the losses 
y_flat =  tf.reshape(y, [-1])
losses = tf.nn.sparse_softmax_cross_entropy_with_logits(logits_flat, y_flat)
 
# Mask the losses
mask = tf.sign(tf.to_float(y_flat))
masked_losses = mask * losses
 
# Bring back to [B, T] shape
masked_losses = tf.reshape(masked_losses,  tf.shape(y))
 
# Calculate mean loss
mean_loss_by_example = tf.reduce_sum(masked_losses, reduction_indices=1) / example_len
mean_loss = tf.reduce_mean(mean_loss_by_example)

```
