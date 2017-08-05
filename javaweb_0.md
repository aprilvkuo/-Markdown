---
title: java网站框架 mark
date: 2016-10-01 11:27:50
tags: [java]
photos: /images/javaweb.jpg
---

# SSH框架

一般指的是Struts、Spring、Hibernate，后来Struts2代替了Struts。最近5年，Struts2已经被Spring MVC代替，而Hibernate基本也被iBatis/MyBatis代替。

所以你真正需要了解的是Spring，Spring你需要了解两个概念AOP和IOC，更进一步就是Spring的核心技术“动态代理”。

持久层框架看看Hibernate/iBatis/MyBatis，研究一下Spring的数据库事务管理，各个持久层框架式如何实现ORM的，了解至少一种缓存框架，知道什么是数据库连接池。和数据库的交互最核心的不是ORM，而是掌握和数据库相关的能力，比如数据库编程、SQL优化、对范式的理解。

MVC框架Struts2和Spring MVC，你需要知道他们在web.xml文件里配置了一些什么，Struts2/Spring MVC接到前台请求之后经过哪些步骤之后转到Action/Controller，return之后Struts2/Spring MVC又作了些什么。还有就是Filter、Listener和Struts2/Spring MVC的拦截器各有什么特点，适合处理什么样的问题。
