---
title: tensorflow_Saver的用法
date: 2017-04-30 13:37:55
tags: Tensorflow
categories: [Tensorflow]
---
# Saver的背景介绍
我们经常在训练完一个模型之后希望保存训练的结果，这些结果指的是模型的参数，以便下次迭代的训练或者用作测试。Tensorflow针对这一需求提供了Saver类。
Saver类提供了向checkpoints文件保存和从checkpoints文件中恢复变量的相关方法。Checkpoints文件是一个二进制文件，它把变量名映射到对应的tensor值 。
只要提供一个计数器，当计数器触发时，Saver类可以自动的生成checkpoint文件。这让我们可以在训练过程中保存多个中间结果。例如，我们可以保存每一步训练的结果。
为了避免填满整个磁盘，Saver可以自动的管理Checkpoints文件。例如，我们可以指定保存最近的N个Checkpoints文件。
2. Saver的实例
下面以一个例子来讲述如何使用Saver类
```python 
[python] view plain copy
import tensorflow as tf  
import numpy as np  
  
isTrain = True  
train_steps = 100  
checkpoint_steps = 50  
checkpoint_dir = ''  
  
x = tf.placeholder(tf.float32, shape=[None, 1])  
y = 4 * x + 4  
  
w = tf.Variable(tf.random_normal([1], -1, 1))  
b = tf.Variable(tf.zeros([1]))  
y_predict = w * x + b  
  
  
loss = tf.reduce_mean(tf.square(y - y_predict))  
optimizer = tf.train.GradientDescentOptimizer(0.5)  
train = optimizer.minimize(loss)  
  
isTrain = False  
train_steps = 100  
checkpoint_steps = 50  
checkpoint_dir = ''  
  
saver = tf.train.Saver()  # defaults to saving all variables - in this case w and b  
x_data = np.reshape(np.random.rand(10).astype(np.float32), (10, 1))  
  
with tf.Session() as sess:  
    sess.run(tf.initialize_all_variables())  
    if isTrain:  
        for i in xrange(train_steps):  
            sess.run(train, feed_dict={x: x_data})  
            if (i + 1) % checkpoint_steps == 0:  
                saver.save(sess, checkpoint_dir + 'model.ckpt', global_step=i+1)  
    else:  
        ckpt = tf.train.get_checkpoint_state(checkpoint_dir)  
        if ckpt and ckpt.model_checkpoint_path:  
            saver.restore(sess, checkpoint_dir+ckpt.model_checkpoint_path)  
        else:  
            pass  
        print(sess.run(w))  
        print(sess.run(b))  
```
isTrain：用来区分训练阶段和测试阶段，True表示训练，False表示测试
train_steps：表示训练的次数，例子中使用100
checkpoint_steps：表示训练多少次保存一下checkpoints，例子中使用50
checkpoint_dir：表示checkpoints文件的保存路径，例子中使用当前路径

## 训练阶段
使用Saver.save()方法保存模型：
sess：表示当前会话，当前会话记录了当前的变量值
checkpoint_dir + 'model.ckpt'：表示存储的文件名
global_step：表示当前是第几步
训练完成后，当前目录底下会多出5个文件。

打开名为“checkpoint”的文件，可以看到保存记录，和最新的模型存储位置。

##测试阶段
 测试阶段使用saver.restore()方法恢复变量：
sess：表示当前会话，之前保存的结果将被加载入这个会话
ckpt.model_checkpoint_path：表示模型存储的位置，不需要提供模型的名字，它会去查看checkpoint文件，看看最新的是谁，叫做什么。

# 选择存储和恢复哪些变量

如果你不给tf.train.Saver()传入任何参数，那么saver将处理graph中的所有变量。其中每一个变量都以变量创建时传入的名称被保存。

有时候在检查点文件中明确定义变量的名称很有用。举个例子，你也许已经训练得到了一个模型，其中有个变量命名为"weights"，你想把它的值恢复到一个新的变量"params"中。

有时候仅保存和恢复模型的一部分变量很有用。再举个例子，你也许训练得到了一个5层神经网络，现在想训练一个6层的新模型，可以将之前5层模型的参数导入到新模型的前5层中。

你可以通过给tf.train.Saver()构造函数传入Python字典，很容易地定义需要保持的变量及对应名称：键对应使用的名称，值对应被管理的变量。

注意：

如果需要保存和恢复模型变量的不同子集，可以创建任意多个saver对象。同一个变量可被列入多个saver对象中，只有当saver的restore()函数被运行时，它的值才会发生改变。
如果你仅在session开始时恢复模型变量的一个子集，你需要对剩下的变量执行初始化op。详情请见tf.initialize_variables()。

```python
# Create some variables.
v1 = tf.Variable(..., name="v1")
v2 = tf.Variable(..., name="v2")
...
# Add ops to save and restore only 'v2' using the name "my_v2"
saver = tf.train.Saver({"my_v2": v2})
# Use the saver object normally after that.
...
```


 
