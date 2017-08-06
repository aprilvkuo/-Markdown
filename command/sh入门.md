# sh入门

1. “#!” 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种Shell。echo命令用于向窗口输出文本.

2. 使用变量时要用   $   ,  推荐加上花括号  {}

3. 只读变量。

   ```
   myUrl="http://see.xidian.edu.cn/cpp/shell/"
   readonly myUrl

   ```

4. 删除变量。__unset__



##  特殊变量

1. $$ 表示PID，当前shell的id

2. 变量

###  \$* 和 $@ 的区别

$* 和 $@ 都表示传递给函数或脚本的所有参数，不被双引号(" ")包含时，都以"$1" "$2" … "$n" 的形式输出所有参数。

但是当它们被双引号(" ")包含时，"$*" 会将所有的参数作为一个整体，以"$1 $2 … $n"的形式输出所有参数；"$@" 会将各个参数分开，以"$1" "$2" … "$n" 的形式输出所有参数。

### 退出状态

$? 可以获取上一个命令的退出状态。所谓退出状态，就是上一个命令执行后的返回结果。

退出状态是一个数字，一般情况下，大部分命令执行成功会返回 0，失败返回 1。

不过，也有一些命令返回其他值，表示不同类型的错误。

## 指令

1. echo :会自动换行
2. printf：不会自动换行

> 这里仅说明与C语言printf()函数的不同：printf 命令不用加括号format-string 可以没有引号，但最好加上，单引号双引号均可。参数多于格式控制符(%)时，format-string 可以重用，可以将所有参数都转换。arguments 使用空格分隔，不用逗号。
>
> ```
> # format-string为双引号
> $ printf "%d %s\n" 1 "abc"
> 1 abc
> # 单引号与双引号效果一样 
> $ printf '%d %s\n' 1 "abc" 
> 1 abc
> # 没有引号也可以输出
> $ printf %s abcdef
> abcdef
> # 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
> $ printf %s abc def
> abcdef
> $ printf "%s\n" abc def
> abc
> def
> $ printf "%s %s %s\n" a b c d e f g h i j
> a b c
> d e f
> g h i
> j
> # 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
> $ printf "%s and %d \n" 
> and 0
> # 如果以 %d 的格式来显示字符串，那么会有警告，提示无效的数字，此时默认置为 0
> $ printf "The first program always prints'%s,%d\n'" Hello Shell
> -bash: printf: Shell: invalid number
> The first program always prints 'Hello,0'
> $
> ```



1. chmod
2. read   
3. date :时间
4. who
5. ​

## Shell 替换

```
#!/bin/bash
a=10
echo -e "Value of a is $a \n"
```

这里 -e 表示对转义字符进行替换，不用-e 将输出```Value of a is 10\n```

### 命令替换

命令替换是指Shell可以先执行命令，将输出结果暂时保存，在适当的地方输出。

命令替换的语法：``command``注意是反引号，不是单引号，这个键位于 Esc 键下方。

### 变量替换

变量替换可以根据变量的状态（是否为空、是否定义等）来改变它的值

可以使用的变量替换形式：

| 形式              | 说明                                       |
| --------------- | ---------------------------------------- |
| ${var}          | 变量本来的值                                   |
| ${var:-word}    | 如果变量 var 为空或已被删除(unset)，那么返回 word，但不改变 var 的值。 |
| ${var:=word}    | 如果变量 var 为空或已被删除(unset)，那么返回 word，并将 var 的值设置为 word。 |
| ${var:?message} | 如果变量 var 为空或已被删除(unset)，那么将消息 message 送到标准错误输出，可以用来检测变量 var 是否可以被正常赋值。若此替换出现在Shell脚本中，那么脚本将停止运行。 |
| ${var:+word}    | 如果变量 var 被定义，那么返回 word，但不改变 var 的值。      |

## Shell 运算符

加法：

```
#!/bin/bash
val=`expr 2 + 2`
echo "Total value : $val"
```

两点注意：表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。完整的表达式要被  \`\`包含，注意这个字符不是常用的单引号，在 Esc 键下边。

```
#!/bin/sh

a=10
b=20
val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a is equal to b"
fi

if [ $a != $b ]
then
   echo "a is not equal to b"
fi
```

- 乘号(*)前边必须加反斜杠(\)才能实现乘法运算；
- if...then...fi 是条件语句，后续将会讲解。

### 关系运算符

| 运算符  | 说明                            | 举例                      |
| ---- | ----------------------------- | ----------------------- |
| -eq  | 检测两个数是否相等，相等返回 true。          | [ $a -eq $b ] 返回 true。  |
| -ne  | 检测两个数是否相等，不相等返回 true。         | [ $a -ne $b ] 返回 true。  |
| -gt  | 检测左边的数是否大于右边的，如果是，则返回 true。   | [ $a -gt $b ] 返回 false。 |
| -lt  | 检测左边的数是否小于右边的，如果是，则返回 true。   | [ $a -lt $b ] 返回 true。  |
| -ge  | 检测左边的数是否大等于右边的，如果是，则返回 true。  | [ $a -ge $b ] 返回 false。 |
| -le  | 检测左边的数是否小于等于右边的，如果是，则返回 true。 | [ $a -le $b ] 返回 true。  |

```
if [ $a -ne $b ]
then
   echo "$a -ne $b: a is not equal to b"
else
   echo "$a -ne $b : a is equal to b"
fi
```

### 布尔运算符

| 运算符  | 说明                                 | 举例                                    |
| ---- | ---------------------------------- | ------------------------------------- |
| !    | 非运算，表达式为 true 则返回 false，否则返回 true。 | [ ! false ] 返回 true。                  |
| -o   | 或运算，有一个表达式为 true 则返回 true。         | [ $a -lt 20 -o $b -gt 100 ] 返回 true。  |
| -a   | 与运算，两个表达式都为 true 才返回 true。         | [ $a -lt 20 -a $b -gt 100 ] 返回 false。 |

## 文件测试运算符

文件测试运算符用于检测 Unix 文件的各种属性。

```
#!/bin/sh
file="/var/www/tutorialspoint/unix/test.sh"
if [ -r $file ]
then
   echo "File has read access"
else
   echo "File does not have read access"
fi
if [ -w $file ]
then
   echo "File has write permission"
else
   echo "File does not have write permission"
fi
if [ -x $file ]
then
   echo "File has execute permission"
else
   echo "File does not have execute permission"
fi
if [ -f $file ]
then
   echo "File is an ordinary file"
else
   echo "This is sepcial file"
fi
if [ -d $file ]
then
   echo "File is a directory"
else
   echo "This is not a directory"
fi
if [ -s $file ]
then
   echo "File size is zero"
else
   echo "File size is not zero"
fi
if [ -e $file ]
then
   echo "File exists"
else
   echo "File does not exist"
fi
```

## 字符串

## 单引号

```
str='this is a string'
```

单引号字符串的限制：

- 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
- 单引号字串中不能出现单引号（对单引号使用转义符后也不行）。

## 双引号

```
your_name='qinjx'str="Hello, I know your are \"$your_name\"! \n"
```

双引号的优点：

- 双引号里可以有变量
- 双引号里可以出现转义字符

## 获取字符串长度

```
string="abcd"echo ${#string} #输出 4
```

## 提取子字符串

```
string="alibaba is a great company"echo ${string:1:4} #输出liba
```

## 查找子字符串

```
string="alibaba is a great company"echo `expr index "$string" is`
```

## 数组定义

## 定义数组

在Shell中，用括号来表示数组，数组元素用“空格”符号分割开。定义数组的一般形式为：

​    array_name=(value1 ... valuen)

例如：

```
array_name=(value0 value1 value2 value3)
```

## 读取数组

读取数组元素值的一般格式是：

​    ${array_name[index]}

例如：

```
valuen=${array_name[2]}
```

使用@ 或 * 可以获取数组中的所有元素，例如：`${array_name[*]}${array_name[@]}`

## 获取数组的长度

获取数组长度的方法与获取字符串长度的方法相同，例如：

```
# 取得数组元素的个数length=${#array_name[@]}# 或者length=${#array_name[*]}# 取得数组单个元素的长度lengthn=${#array_name[n]}
```



## if … else… 语句

```
if [ expression ]
then
   Statement(s) to be executed if expression is true
fi
```

如果 expression 返回 true，then 后边的语句将会被执行；如果返回 false，不会执行任何语句。

最后必须以 fi 来结尾闭合 if，fi 就是 if 倒过来拼写，后面也会遇见。

注意：expression 和方括号([ ])之间必须有空格，否则会有语法错误。

## test 命令

Shell中的 test 命令用于检查某个条件是否成立，它可以进行数值、字符和文件三个方面的测试。