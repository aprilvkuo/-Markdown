---
title: 爬虫笔记0----知乎爬虫学习
date: 2016-10-06 17:39:28
tags: [Spider]
categories: [Spider]
---
# html解析器

[HTML解析原理](http://www.cnblogs.com/NetSos/archive/2010/11/29/1891194.html)

[HTML解析器对比](https://zh.wikipedia.org/wiki/HTML%E8%A7%A3%E6%9E%90%E5%99%A8%E5%AF%B9%E6%AF%94)

下表列出了主要的解析器,以及它们的优缺点:

|解析器|使用方法|优势|劣势|
|:------|:---|:------|:------|
|Python标准库|BeautifulSoup(markup, "html.parser")|	Python的内置标准库;执行速度适中;文档容错能力强|(Python 2.7.3 or 3.2.2)前 的版本中文档容错能力差
|lxml HTML 解析器|	BeautifulSoup(markup, "lxml")	|速度快;文档容错能力强|需要安装C语言库|
|lxml XML 解析器	| 1. BeautifulSoup(markup, ["lxml", "xml"]) 2. BeautifulSoup(markup, "xml")|速度快;唯一支持XML的解析器|需要安装C语言库|
|html5lib|BeautifulSoup(markup, "html5lib")	|最好的容错性; 以浏览器的方式解析文档 ; 生成HTML5格式的文档| * 速度慢; 不依赖外部扩展|
推荐使用lxml作为解析器,因为效率更高. 在Python2.7.3之前的版本和Python3中3.2.2之前的版本,必须安装lxml或html5lib, 因为那些Python版本的标准库中内置的HTML解析方法不够稳定.

## [Beautiful Soup 4.2.0 文档](https://www.crummy.com/software/BeautifulSoup/bs4/doc.zh/)

- 几个简单的浏览结构化数据的方法:

                soup.title
                # <title>The Dormouse's story</title>

                soup.title.name
                # u'title'

                soup.title.string
                # u'The Dormouse's story'

                soup.title.parent.name
                # u'head'

                soup.p
                # <p class="title"><b>The Dormouse's story</b></p>

                soup.p['class']
                # u'title'

                soup.a
                # <a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>

                soup.find_all('a')
                # [<a class="sister" href="http://example.com/elsie" id="link1">Elsie</a>,
                #  <a class="sister" href="http://example.com/lacie" id="link2">Lacie</a>,
                #  <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>]

                soup.find(id="link3")
                # <a class="sister" href="http://example.com/tillie" id="link3">Tillie</a>

- Beautiful Soup将复杂HTML文档转换成一个复杂的树形结构,每个节点都是Python对象,所有对象可以归纳为4种: __Tag , NavigableString , BeautifulSoup , Comment__ .

# MySql

* 登陆mysql数据库可以通过如下命令：

        mysql -u root -p

-u 表示选择登陆的用户名， -p 表示登陆的用户密码，上面命令输入之后会提示输入密码，此时输入密码就可以登录到mysql。

* 看当前的数据库

        show databases;

* 切换到mysql数据库

        use mysql

* 显示当前数据库的表单

        show tables

# post

HTTP/1.1 协议规定的 HTTP 请求方法有 __OPTIONS、GET、HEAD、POST、PUT、DELETE、TRACE、CONNECT__  这几种。其中 __POST__ 一般用来向服务端提交数据，下面主要讨论 [POST 提交数据的几种方式](http://www.cnblogs.com/aaronjs/p/4165049.html)。

我们知道，HTTP 协议是以 ASCII 码传输，建立在 TCP/IP 协议之上的应用层规范。规范把 HTTP 请求分为三个部分：状态行、请求头、消息主体。类似于下面这样：
```
<method> <request-url> <version>
<headers>
<entity-body></entity-body></headers></version></request-url></method>
```

## 在chrome中查看post 和get包

在chrome ，F12可以调用开发者工具
在network中可以观察得到post和get的各种信息。如下图所示，知乎邓丽界面主要post下面几个变量：
以用手机登录为例子：
|变量|作用|
|:--|:--|
|_xsrf:| 应该为每个登录页面的特定的序列号。|
|phone_num:|账号|
|password:|密码|
|remember_me:|记住我选项的标识|
|capycha_type:|验证码类型（应该没有验证码时候默认为cn）|

# python 中模拟网站登录

## request.get  / post
[Python网络请求模块requests](http://blog.csdn.net/nicewuranran/article/details/52060125)
[requset quickstart](http://docs.python-requests.org/en/latest/user/quickstart/)

使用requst能得到一种为Response 的对象。可以从这个对象中获取所有我们想要的信息。
得到Response对象。

Response.text 与 Response.content区别：text会自动编码，而content得到是unicode
``` python
In [8]: import requests

In [9]: r = requests.get('https://api.github.com/events')

In [10]: print r
<Response [200]>

In [11]: r.headers
Out[11]: {'X-XSS-Protection': '1; mode=block', 'Content-Security-Policy': "default-src 'none'", 'Access-Control-Expose-Headers': 'ETag, Link, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval', 'Transfer-Encoding': 'chunked', 'Last-Modified': 'Thu, 06 Oct 2016 08:50:28 GMT', 'Access-Control-Allow-Origin': '*', 'X-Frame-Options': 'deny', 'Status': '200 OK', 'X-Served-By': 'bd82876e9bf04990f289ba22f246ee9b', 'X-GitHub-Request-Id': 'CA76FD6D:4452:46246C1:57F61054', 'ETag': 'W/"3460d68b0b16b368af83a52fb4cbdfee"', 'Link': '<https://api.github.com/events?page=2>; rel="next", <https://api.github.com/events?page=10>; rel="last"', 'Date': 'Thu, 06 Oct 2016 08:50:29 GMT', 'X-RateLimit-Remaining': '57', 'Strict-Transport-Security': 'max-age=31536000; includeSubdomains; preload', 'Server': 'GitHub.com', 'X-Poll-Interval': '60', 'X-GitHub-Media-Type': 'github.v3', 'X-Content-Type-Options': 'nosniff', 'Content-Encoding': 'gzip', 'Vary': 'Accept, Accept-Encoding', 'X-RateLimit-Limit': '60', 'Cache-Control': 'public, max-age=60, s-maxage=60', 'Content-Type': 'application/json; charset=utf-8', 'X-RateLimit-Reset': '1475747222'}

In [12]:  r = requests.post('http://httpbin.org/post', data = {'key':'value'})

In [13]: r
Out[13]: <Response [200]>
```

传送URL中的参数
``` python
>>> payload = {'key1': 'value1', 'key2': ['value2', 'value3']}

>>> r = requests.get('http://httpbin.org/get', params=payload)
>>> print(r.url)
http://httpbin.org/get?key1=value1&key2=value2&key2=value3
```

## response 中的内容

``` python
>>> import requests

>>> r = requests.get('https://api.github.com/events')
>>> r.text
u'[{"repository":{"open_issues":0,"url":"https://github.com/...
>>> r.encoding
'utf-8'
>>> r.encoding = 'ISO-8859-1'
```
requsets能够自动对服务器端的内容进行解码，大多数的解码都是比较完美的。Requests模块通过HTTP头文件对r.text的编码进行预测。而且用户可以改变编码，当使用不同的编码时，调用r.text会得到不同的值，用户可以通过r.content来获取不同部位的信息的编码。

## 自定义的头文件
自定义的头文件优先级次于特殊的头文件。
> Note: Custom headers are given less precedence than more specific sources of information. For instance:

> - Authorization headers set with headers= will be overridden if credentials are specified in .netrc, which in turn will be overridden by the auth= parameter.
> - Authorization headers will be removed if you get redirected off-host.
> - Proxy-Authorization headers will be overridden by proxy credentials provided in the URL.
> - Content-Length headers will be overridden when we can determine the length of the content.

```python
>>> url = 'https://api.github.com/some/endpoint'
>>> headers = {'user-agent': 'my-app/0.0.1'}

>>> r = requests.get(url, headers=headers)
```

## 设置超时

```python
>>> requests.get('http://github.com', timeout=0.001)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
requests.exceptions.Timeout: HTTPConnectionPool(host='github.com', port=80): Request timed out. (timeout=0.001)
```

## 重定向与历史记录

For example, GitHub redirects all HTTP requests to HTTPS:
301 永久性转移(Permanently Moved),SEO必用的招式，会把旧页面的PR等信息转移到新页面；
302 暂时性转移(Temporarily Moved),很常用的招式，也是SEO最容易被判作弊的方式。

```python
>>> r = requests.get('http://github.com')

>>> r.url
'https://github.com/'

>>> r.status_code
200

>>> r.history
[<Response [301]>]
```

If you're using GET, OPTIONS, POST, PUT, PATCH or DELETE, you can disable redirection handling with the allow_redirects parameter:
```python
>>> r = requests.get('http://github.com', allow_redirects=False)

>>> r.status_code
301

>>> r.history
[]
```

If you're using HEAD, you can enable redirection as well:
```python
>>> r = requests.head('http://github.com', allow_redirects=True)

>>> r.url
'https://github.com/'

>>> r.history
[<Response [301]>]
```

## Cookies

获取response中的Cookies：

```python
>>> url = 'http://example.com/some/cookie/setting/url'
>>> r = requests.get(url)

>>> r.cookies['example_cookie_name']
'example_cookie_value'
```

自己设置cookies
```python
>>> url = 'http://httpbin.org/cookies'
>>> cookies = dict(cookies_are='working')

>>> r = requests.get(url, cookies=cookies)
>>> r.text
'{"cookies": {"cookies_are": "working"}}'
```

## Response Status Codes

```python
>>> r = requests.get('http://httpbin.org/get')
>>> r.status_code
200
```

## Session
Session对象让你可以通过request对一些参数进行持续访问，也加长了cookies的生存周期。当你对一个host进行多个requests访问时，TCP将会被重复使用，这使得性能得到大的提升。

Session拥有Requsets的所有API。

```python
s = requests.Session()

s.get('http://httpbin.org/cookies/set/sessioncookie/123456789')
r = s.get('http://httpbin.org/cookies')

print(r.text)
# '{"cookies": {"sessioncookie": "123456789"}}'
```
Session还可以设置request的参数。（ session-level values ）
```python
s = requests.Session()
s.auth = ('user', 'pass')
s.headers.update({'x-test': 'true'})

# both 'x-test' and 'x-test2' are sent
s.get('http://httpbin.org/headers', headers={'x-test2': 'true'})
```
但是这些参数不会持续整个requests周期。
```python
s = requests.Session()

r = s.get('http://httpbin.org/cookies', cookies={'from-my': 'browser'})
print(r.text)
# '{"cookies": {"from-my": "browser"}}'

r = s.get('http://httpbin.org/cookies')
print(r.text)
# '{"cookies": {}}'
```

下面的表示方法，当跳出循环时，能确保讲session关闭。
```python
with requests.Session() as s:
    s.get('http://httpbin.org/cookies/set/sessioncookie/123456789')
```
### Prepared Requests
在发送request请求前对body或者header进行修改。
Request.prepare()
Session.prepare_request()

## SSL验证

```python
>>> requests.get('https://github.com', verify='/path/to/certfile')
or persistent:
#or
s = requests.Session()
s.verify = '/path/to/certfile'
```

#cookielib



http://zihaolucky.github.io/using-python-to-build-zhihu-cralwer/
http://www.cnblogs.com/ly941122/p/5401950.html
