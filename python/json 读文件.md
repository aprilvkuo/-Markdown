# json 读文件

```python
import json

test_dict = {'bigberg': [7600, {1: [['iPhone', 6300], ['Bike', 800], ['shirt', 300]]}]}
print(test_dict)
print(type(test_dict))
#dumps 将数据转换成字符串
json_str = json.dumps(test_dict)
print(json_str)
print(type(json_str))
```

dumps 将字典转化为字符串。

loads 将字符串转化为字典。

dump 将数据写到json文件中。

load 把文件打开，并把字符串变换为数据类型



(来源)[http://www.cnblogs.com/bigberg/p/6430095.html]