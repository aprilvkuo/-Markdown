## 计算图。

```
tf.Graph()
```

**tf.Graph.device** 还能指定运行计算的设备。

## 默认的计算图。

```python
tf.get_default_graph()
```

## 张量

张量等同于数学中向量，张量并没有保存数字，而是保存如何得到这些数字的过程。

张量主要保存了三个属性：

```
<tf.Tensor 'add_1:0' shape=(2,) dtype=float32>
```

name， shape ， type。

其中name 以```node:src_output```,节点名称，第几个输出。

TensorFlow 会进行属性检查。

张量主要分为两类：

1. 对中间结果的引用。 在这里，张量就是对生成结果的引用，这样在之后的计算中可以直接使用变量，不需要再去生成变量。

   ```
   a = tf.constant([1,2],name='a')
   ```

2. 可以用张量来得到计算结果。```tf.Session().run(result)```

## 会话（Session）

使用的会话模式主要有两种：

1. 需要明确调用Session生成和Session关闭函数。

   ```
   sess = tf.Session()
   ...
   sess.close()
   ```

2. 通过上下文管理器来使用Session。

   ```
   with tf.Session() as sess:
   	...
   	# 不需要调用close了
   ```



Session 和 Graph 比较：  都有默认，Graph会自动生成一个默认的计算图，会自动加入，但是Session需要手动加入。 **默认Session被指定了，可以用tf.Tensor.eval**来计算张量取值。

```
sess = tf.Session()
with sess.as_default():
	print (result.eval())
	
等价于：

print (sess.run(result))
print (result.eval(session=sess))
```



可以用过设置默认会话的方式来获取张量的取值更加方便。

提供了直接构建默认会话的方式的函数，

```
sess = tf.InteracticeSession()
print (result.eval())
sess.close()
```

## 变量

```
weights = tf.Variable(tf.random_normal([2,3],stddec=2))
```

变量的输出结果是一个张量，变量是特别的张量。

变量的type是无法改变的的，但是shape有可能改变。但是需要通过设置设置为：

```
tf.assign(w1,w2,validate_shape=False)#但是实际中很少使用
```

## 初始化

变量使用前应该需要初始化。

```
sess.run(weights.initializer)
```

也可以直接完成所有变量的初始化

```
init_op = tf.initialize_all_variables()
sess.run(init_op)
```

## placeholder

每生成一个常量，需要在计算图中增加一个节点，这样计算图会非常大。

可以通过placeholder传入计算图，不需要生成大量的常量。

TensorFlow中提供了placehoder，定义时，数据类型是需要指定的。

维度信息可以推导出来，不一定要给。

```
x = tf.placeholder(tf.float32,shape=(1,2),name="input)
```

**placeholder** 使用前需要一个feed_dict来指定x的值。 **feed_dict** 是一个字典。

## 矩阵乘法

```*``` 直接将矩阵对应位置乘起来：```a[1][1]*b[1][1]```

矩阵乘法用的是： ```tf.matmul```

## 交叉熵实现

```
tf.nn.softmax_cross_entropy_with_logits(y,y_)
//加速
tf.nn.spare_softmax_cross_entropy_with_logits(y,y_)
```

## 平方损失函数

```
tf.reduce_mean(tf.square(y_-y))
```

## 指数衰减

学习率的设置，当使用连续的指数衰减学习率时，不同的训练数据有不同的学习率。

```
learning_rate = tf.train.exponential_decay\
				(0.1,global_step,100,0.96.staircase=True)
learning_step =tf.train.GradientDescentOptimizer(learning_rate)\
			 	.minmize()		
```

初始学习率为0.1， 指定了staircase=True，所以每100轮后学习率乘以0.96.

## 过拟合问题—正则化

L1与L2正则：

1. L1正则会使得参数稀疏化，但是L2不会。参数稀疏可以达到类似于特征选择的功能。当参数的值特别小的时候，参数的平方基本可以忽略。
2. L1正则化的计算公式不可导，L2可导。 因为优化时候需要计算损失函数的偏导数，所以L2正则化损失函数的优化更加简洁。 L1的优化会复杂。

```
tf.contrib.layers.l2_regularizer(lambda)(w)
```

lambda表示正则化的权重，w为需要计算正则化损失的参数。

将损失函数加入集合(collection):

```
tf.add_to_collection('losses',mse_loss) #多个
tf.add_n(tf.get_collection('losses'))
```



