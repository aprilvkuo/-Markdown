---
title: tensorflow_0_基本语法
date: 2017-04-30 13:36:09
tags: Tensorflow
categories: [Tensorflow]
---

# numpy
numpy数组计算中*和dot是有很大区别的

1.numpy乘法运算中"*"是数组元素逐个计算具体代码如下
``` python
a = np.array([1,2],[1,1])
b = np.array([1,2],[1,1])
a * b
# [1,4] [1,1]
c = np.dot(a,b)
# [3,4][2,3]
```
2.numpy乘法运算中dot是按照矩阵乘法的规则来运算的具体实现代码如下：
Dot product of two arrays.

For 2-D arrays it is equivalent to matrix multiplication, and for 1-D arrays to inner product of vectors (without complex conjugation). For N dimensions it is a sum product over the last axis of a and the second-to-last of b:

```
dot(a, b)[i,j,k,m] = sum(a[i,j,:] * b[k,:,m])
#最后一个维度和倒数第二个维度
```
# 步骤
1. 建立计算图
2. 运行计算图
> 下面介绍几种常见的图节点：

## constant类型
 it takes no inputs, and it outputs a value it stores internally. 
类似于constant 变量，存储常量。
```
node1 = tf.constant(3.0, tf.float32)
node2 = tf.constant(4.0) # also tf.float32 implicitly
print(node1, node2)
#The final print statement produces

Tensor("Const:0", shape=(), dtype=float32) Tensor("Const_1:0", shape=(), dtype=float32)
```
### 加法
```
node3 = node1 + node2
node3 = tf.add(node1,node2)
```
两者等价，其实就是```tf.assign```与```=```的差异。
在计算精度上，二者并没有差别。运算符重载的形式a+b，会在内部转换为，a.__add__(b)，而a.__add__(b)会再一次地映射为tf.add，在 math_ops.py中相关的映射如下：
```_OverrideBinaryOperatorHelper(gen_math_ops.add, "add")```
 
## placeholders变量
A placeholder is a promise to provide a value __later__.
```
a = tf.placeholder(tf.float32)
b = tf.placeholder(tf.float32)
adder_node = a + b  # + provides a shortcut for tf.add(a, b)
print(sess.run(adder_node, {a: 3, b:4.5}))
print(sess.run(adder_node, {a: [1,3], b: [2, 4]}))

#7.5
#[ 3.  7.]

#We can make the computational graph more complex by adding another operation. For example,
add_and_triple = adder_node * 3.
print(sess.run(add_and_triple, {a: 3, b:4.5}))

#22.5
```

## Variables
在机器学习中，我们往往希望输入不同的输入值，得到不同的输出结果。 而**Variables**可以实现上面这个功能，就是机器学习中的参数。

```
W = tf.Variable([.3], tf.float32)
b = tf.Variable([-.3], tf.float32)
x = tf.placeholder(tf.float32)
linear_model = W * x + b
```
Constant 一旦定义了就会被初始化，而且值不会发生改变。
**相反的**，variable定义时候不会初始化，我们需要在程序中初始化：
```
init = tf.global_variables_initializer()
sess.run(init)
```
It is important to realize init is a handle to the TensorFlow sub-graph that initializes all the global variables. Until we call sess.run, the variables are uninitialized.

## 预测函数与损失函数
```
y = tf.matmul(x,W) + b
cross_entropy = tf.reduce_mean(
    tf.nn.softmax_cross_entropy_with_logits(labels=y_, logits=y))
```
## 模型训练
```
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)
for _ in range(1000):
  batch = mnist.train.next_batch(100)
  train_step.run(feed_dict={x: batch[0], y_: batch[1]})
```
## 模型评估
```
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_,1))
```
> y 是二维，  m个样例，n个类别  $[[y_0,y_1,...y_n],...]$ axis = 0 表示最外层的[]

## Dropout
为了减少过拟合，我们在输出层之前加入dropout。我们用一个placeholder来代表一个神经元的输出在dropout中保持不变的概率。这样我们可以在训练过程中启用dropout，在测试过程中关闭dropout。 TensorFlow的tf.nn.dropout操作除了可以屏蔽神经元的输出外，还会自动处理神经元输出值的scale。所以用dropout的时候可以不用考虑scale。
```
keep_prob = tf.placeholder("float")
h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)
```

## Summary
Summary是对网络中Tensor取值进行监测的一种Operation。这些操作在图中是“外围”操作，不影响数据流本身。
调用tf.scalar_summary系列函数时，就会向默认的collection中添加一个Operation。
```

#定义变量及训练数据的摘要操作

tf.summary.scalar('max', tf.reduce_max(var))

tf.summary.histogram('histogram', var)

tf.summary.image('input', image_shaped_input, 10)



#定义合并变量操作，一次性生成所有摘要数据

merged = tf.summary.merge_all()



#定义写入摘要数据到事件日志的操作

train_writer = tf.train.SummaryWriter(FLAGS.log_dir + '/train', sess.graph)

test_writer = tf.train.SummaryWriter(FLAGS.log_dir + '/test')



#执行训练操作，并把摘要信息写入到事件日志

summary, _ = sess.run([merged, train_step], feed_dict=feed_dict(True))

train_writer.add_summary(summary, i)



  #下载示例code，并执行模型训练

  python mnist_with_summaries.py



#启动TensorBoard，TensorBoard的UI地址为http://ip_address:6006

tensorboard --logdir=/path/to/log-directory
```
再次回顾“零存整取”原则：创建网络的各个层次都可以添加监测；在添加完所有监测，初始化sess之前，统一用tf.merge_all_summaries获取。

查看

SummaryWriter文件中存储的是序列化的结果，需要借助TensorBoard才能查看。

在命令行中运行tensorboard，传入存储SummaryWriter文件的目录：

```tensorboard --logdir /tmp/log```

完成后会提示：

```You can navigate to http://127.0.1.1:6006```


可以直接使用服务器本地浏览器访问这个地址（本机6006端口），或者使用远程浏览器访问服务器ip地址的6006端口。

# Fuction
## Session() and IntetactiveSession()
> One major change is the use of an InteractiveSession, which allows us to run variables without needing to constantly refer to the session object (less typing!). Code blocks below are broken into different cells. If you see a break in the code, you will need to run the previous cell first. Also, if you aren’t otherwise confident, ensure all of the code in a given block is type into a cell before you run it.

__不同点：__
1. 最为主要的一句话当属第一句：使用InteractiveSession一个主要的变化是：运行在没有指定会话对象的情况下运行变量。这是与Session（）最大的不同。
2. Session（）使用with..as..后可以不使用close关闭对话，而调用InteractiveSession需要在最后调用close
3. tf中的变量和操作（合称tensor）定义好后，由Session对象合成graph。
一般我们会用tf.Session()对象，就像前面用到的那样，语句如下：
```
import tensorflow as tf  
   
x = tf.constant(10)  
y = tf.constant(23)

with tf.Session() as session:  
    print(sess.run(x))
    print(sess.run(y))
```
上面代码一个session将多个变量整合到graph中去，
__但对于像python原生编辑器，或者jupyter这样的基于浏览器的python编辑器，__要一段一段的输入代码，
于是就有了 tf.InteractiveSession() 这样的交互式会话，它不需要用 "sess.run(变量)”这种形式，而是定义好会话对象后，每次执行tensor时，调用tensor.eval()即可。
如下：
```
import tensorflow as tf  
   
x = tf.constant(10)  
y = tf.constant(23)

sess = tf.Interactive()

print(x.eval())
print(y.eval())

sess.close()
```
上面两段代码可得到同样的结果，区别仅在于编辑模式不同，满足各种生产环境的需要。
两者的的区别将在学习过程中逐步区分。

为了便于使用诸如 IPython 之类的 Python 交互环境, 可以使用InteractiveSession 代替 Session 类, 使用 Tensor.eval() 和 Operation.run() 方法代替 Session.run(). 这样可以避免使用一个变量来持有会话。
## 张量的输出
Tensorflow 需要显式地输出(evaluation)！
```
**In [37]: a = np.zeros((2,2))
In [38]: ta = tf.zeros((2,2))
In [39]: print(a)
[[ 0.  0.]
 [ 0.  0.]]
In [40]: print(ta)
Tensor("zeros_1:0", shape=(2, 2), dtype=float32)
In [41]: print(ta.eval())
[[ 0.  0.]
[ 0. 0.]]
```
当我们想要的到节点的值时候，需要用__session__来运行计算图。
```
sess = tf.Session()
print(sess.run([node1, node2]))
```

## tf.truncated_normal
(shape, mean=0.0, stddev=1.0//方差, dtype=tf.float32, seed=None, name=None)
> Outputs random values from a truncated normal distribution.
The generated values follow a normal distribution with specified mean and standard deviation, except that values whose magnitude is more than 2 standard deviations from the mean are dropped and re-picked.

在这种最常见的情况下，通过tf.truncated_normal函数初始化权重变量，给赋予的shape则是一个二维tensor，其中第一个维度代表该层中权重变量所连接（connect from）的单元数量，第二个维度代表该层中权重变量所连接到的（connect to）单元数量。对于名叫hidden1的第一层，相应的维度则是[IMAGE_PIXELS, hidden1_units]，因为权重变量将图像输入连接到了hidden1层。tf.truncated_normal初始函数将根据所得到的均值和标准差，生成一个随机分布。

## tf.nn.conv2d
(input, filter, strides, padding, use_cudnn_on_gpu=None, name=None)
> 除去name参数用以指定该操作的name，与方法有关的一共五个参数：
1. __第一个参数input__：指需要做卷积的输入图像，它要求是一个Tensor，具有[batch, in_height, in_width, in_channels]这样的shape，具体含义是[训练时一个batch的图片数量, 图片高度, 图片宽度, 图像通道数]，注意这是一个4维的Tensor，要求类型为float32和float64其中之一
2. __第二个参数filter__：相当于CNN中的卷积核，它要求是一个Tensor，具有[filter_height, filter_width, in_channels, out_channels]这样的shape，具体含义是[卷积核的高度，卷积核的宽度，图像通道数，卷积核个数]，要求类型与参数input相同，有一个地方需要注意，第三维in_channels，就是参数input的第四维
3. __第三个参数strides__：卷积时在图像每一维的步长，这是一个一维的向量，长度4
4. __第四个参数padding__：string类型的量，只能是"SAME","VALID"其中之一，这个值决定了不同的卷积方式（后面会介绍） // __Same__ 考虑边缘,卷积核可以__停留__在图像边缘,__VALID边缘设为‘.’__
5. __第五个参数__：use_cudnn_on_gpu:bool类型，是否使用cudnn加速，默认为true
结果返回一个Tensor，这个输出，就是我们常说的feature map

##[tf.nn.max_pool][1]
(value, ksize, strides, padding, name=None)
参数是四个，和卷积很类似：
1. __第一个参数value__：需要池化的输入，一般池化层接在卷积层后面，所以输入通常是feature map，依然是[batch, height, width, channels]这样的shape
2. __第二个参数ksize__：池化窗口的大小，取一个四维向量，一般是[1, height, width, 1]，因为我们不想在batch和channels上做池化，所以这两个维度设为了1
3. __第三个参数strides__：和卷积类似，窗口在每一个维度上滑动的步长，一般也是[1, stride,stride, 1]
4. __第四个参数padding__：和卷积类似，可以取'VALID' 或者'SAME'
返回一个Tensor，类型不变，shape仍然是[batch, height, width, channels]这种形式

## [tf.Graph.name_scope(name)][2]
        返回一个上下文管理器，为操作创建一个层级的name
        一个图维持一个name scope的栈。name_scope(...):声明将一个新的name放入context生命周期的一个栈中。
    name参数如下：
        一个字符串（不以'/' 结尾）将穿件一个新scope name，在这个scope中，上下文中所创建的操作前都加上name这个前缀。如果name之前用过，将调用self.unique_name(name) 确定调用一个唯一的name
        使用g.name_scope(...)捕获之前的scope作为scope：声明将被视为一个“全局”的scope name，这允许重新进入一个已经存在的scope
        None或空字符串将会重置当前的scope name 为最高级（空）的name scope

## tf.sparse_to_dense(sparse_indices, output_shape, sparse_values, default_value, name=None)

除去name参数用以指定该操作的name，与方法有关的一共四个参数：
第一个参数sparse_indices：稀疏矩阵中那些个别元素对应的索引值。
     有三种情况：
     sparse_indices是个数，那么它只能指定一维矩阵的某一个元素
     sparse_indices是个向量，那么它可以指定一维矩阵的多个元素
     sparse_indices是个矩阵，那么它可以指定二维矩阵的多个元素
第二个参数output_shape：输出的稀疏矩阵的shape
第三个参数sparse_values：个别元素的值。
     分为两种情况：
     sparse_values是个数：所有索引指定的位置都用这个数
     sparse_values是个向量：输出矩阵的某一行向量里某一行对应的数（所以这里向量的长度应该和输出矩阵的行数对应，不然报错）
第四个参数default_value：未指定元素的默认值，一般如果是稀疏矩阵的话就是0了

举一个例子：
在mnist里面有一个把数字标签转化成onehot标签的操作，所谓onehot标签就是：
如果标签是6那么对应onehot就是[ 0.  0.  0.  0.  0.  0.  1.  0.  0.  0.]
如果标签是1那么对应onehot就是[ 0.  1.  0.  0.  0.  0.  0.  0.  0.  0.]
如果标签是0那么对应onehot就是[ 1.  0.  0.  0.  0.  0.  0.  0.  0.  0.]
就是把标签变为适用于神经网络输出的形式。

## tf.concat(concat_dim, values, name='concat')
```
t1 = [[1,2,3], [4,5,6]]
t2 = [[7,8,9], [10,11,12]]
tf.concat(0, [t1, t2]) ==> [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
tf.concat(1, [t1, t2]) ==> [[1,2,3,7,8, 9], [4,5,6,10,11, 12]
```

## tf.expand_dims
tf.expand_dims(Tensor, dim) 
为张量+1维。官网的例子：’t’ is a tensor of shape [2] 
shape(expand_dims(t, 0)) ==> [1, 2] 
shape(expand_dims(t, 1)) ==> [2, 1] 
shape(expand_dims(t, -1)) ==> [2, 1]
```
sess = tf.InteractiveSession()
labels = [1,2,3]
x = tf.expand_dims(labels, 0)
print(sess.run(x))
x = tf.expand_dims(labels, 1)
print(sess.run(x))
#>>>[[1 2 3]]
#>>>[[1]
#    [2]
#    [3]]
```

## tf.pack
tf.pack(values, axis=0, name=”pack”) 
Packs a list of rank-R tensors into one rank-(R+1) tensor 
将一个R维张量列表沿着axis轴组合成一个R+1维的张量。

```
  # 'x' is [1, 4]
  # 'y' is [2, 5]
  # 'z' is [3, 6]
  pack([x, y, z]) => [[1, 4], [2, 5], [3, 6]]  # Pack along first dim.
  pack([x, y, z], axis=1) => [[1, 2, 3], [4, 5, 6]]
```


```
# 样例
batch_size = tf.size(labels)
labels = tf.expand_dims(labels, 1)# 变成二维
indices = tf.expand_dims(tf.range(0, batch_size, 1), 1)# 变成二维
concated = tf.concat(1, [indices, labels])# 拼接
onehot_labels = tf.sparse_to_dense(
concated, tf.pack([batch_size, NUM_CLASSES]), 1.0, 0.0)
cross_entropy = tf.nn.softmax_cross_entropy_with_logits(logits,
                                                        onehot_labels,
                                                        name='xentropy')

---》 已经更新为：
labels = tf.to_int64(labels)
cross_entropy = tf.nn.sparse_softmax_cross_entropy_with_logits(
    labels=labels, logits=logits, name='xentropy')
```
  
  
  
  [1]: http://blog.csdn.net/mao_xiao_feng/article/details/53453926
  [2]: http://blog.csdn.net/qiqiaiairen/article/details/53158877