---
title: project_qa_3------Tregex 语法
date: 2016-12-28 09:27:30
tags: [CQA]
categories: [QA]
---
# tregex 语法

## 树的节点的表示
- 直接匹配
比如说NP直接匹配NP,可以用|表示或运算
- 正则表达式匹配
比如说/NN./  ,可以表示NN, NNP, NNS
- 通配符匹配(两个下划线)
表示所有的节点

## 其他的tips

- 用! 可以表示非,如:!NP
- Preceding desc with @ uses basic category /@NP will match NP-SBJ

## 语法
- A < B :  A是B的母节点
- A $ B :  A和B是姐妹节点
- A <iB :  B是A的第i的子节点
- A<<#B :  A on head path of B
- A..B  :  深度优先，Ａ到Ｂ的路径
- A<+(C)N : A dominates B via unbroken chain of Cs
- A<<B  : A是Ｂ的祖先
- A$+B  : B是Ａ的下一个兄弟
- Ａ<:Ｂ :　A是Ｂ的唯一儿子
- A<<-B : B是最右的儿子

## 关系relationship
- 所有的关系与字符串的第一个节点相关
比如：
        NP < NN $ VP
等同于：
        NP < NN & $ VP
NP 有个子节点是NN,且有个兄弟节点是VP
- 但是可以用()改变优先次序
        NP < (NN < dog) $ (VP <<# (barks > VBZ))
An NP both over an NN over ‘dog’ and with a sister VP headed by ‘barks’ under VBZ”

## or |
        NP < NN | < NNS //NP是NN的父节点或者是NNs的节点
        NP < NNS | < NN & $ VP //NP over NNS OR both over NN and w/ sister VP

## [ ,]    可能等同于()
        NP [ < NNS | < NN ] $ VP

## 命名节点
        /NN.?/ $- @JJ|DT=premod
        如果匹配成功,可以用premod表示
## ?
Use the optional relation prefix ‘?’
Ex: NP < (NN ?$- JJ=premod) $+ CC $++ NP
Matches NP over NN with sisters CC and NP
If NN is preceded by JJ, we can retrieve the JJ using the key “premod”
If there is no JJ, the expression will still match
#使用 Tsurgeon class


``` java
Tree t = Tree.valueOf("(ROOT (S (NP (NP (NNP Bank)) (PP (IN of) (NP (NNP America)))) (VP (VBD called)) (. .)))");
TregexPattern pat = TregexPattern.compile("NP <1 (NP << Bank) <2 PP=remove");
TsurgeonPattern surgery = Tsurgeon.parseOperation("excise remove remove");
Tsurgeon.processPattern(pat, surgery, t).pennPrint();




TregexPattern matchPattern = TregexPattern.compile("SQ=sq < (/^WH/ $++ VP)");

List<TsurgeonPattern> ps =
	new ArrayList<TsurgeonPattern>();

TsurgeonPattern p =
	Tsurgeon.parseOperation("relabel sq S");

ps.add(p);

Collection<Tree> result = Tsurgeon.processPatternOnTrees(matchPattern,Tsurgeon.collectOperations(ps),lTrees);
```
#Tsurgeon 语法

## 与语法树上的节点模式匹配

```
  VBZ=vbz $ NP  //将NP节点定义为vbz
```

## 删除语法树上的节点
```
(ROOT
  (SBARQ
    (SQ (NP (NNS Cats))
          (VP (VBP do)
                (VP (WHNP what)
			  (VB eat)))
  (PUNCT ?)))


PUNCT=punct > SBARQ
delete punct
```
delete <name1>…<nameN>
删除语法树上的节点以及节点的所有子节点

## 移动树节点 B的所有子节点 到树节点 A的父节点 之下(如果A是B的祖先先点或者A=B)
```
(ROOT
  (SBARQ
    (SQ (NP (NNS Cats))
          (VP (VBP do)
                (VP (WHNP what)
			  (VB eat))))))

SBARQ=sbarq > ROOT
excise sbarq sbarq

ROOT
  (SQ (NP (NNS Cats))
      (VP (VBP do)
          (VP (WHNP what)
              (VB eat)))))
```
excise <name1> <name2>
移动树节点 B的所有子节点 到树节点 A的父节点 之下(如果A是B的祖先先点或者A=B)
即移动到A本来在的地方

## 剪枝
 prune <name1>…<nameN>
 与delete不同之处,当剪枝后,操作节点的父节点没有子节点,也将子节点减去.

## 插入

```
(ROOT
    (SQ (NP (NNS Cats))
          (VP (VBP do)
                (VP (WHNP what)
		  	 (VB eat)))))


SQ=sq > ROOT !<- /PUNCT/
insert (PUNCT .) >-1 sq
insert  <tree>	 <position>

(ROOT
  (SQ (NP (NNS Cats))
    (VP (VBP do)
        (VP (WHNP what)
	         (VB eat)))
 	  (PUNCT .)))
```
insert <name> <position>
insert <tree>   <position>
<position> := <relation> <name>
<relation>
$+ 	the left sister of the named node
$-		the right sister of the named node
\>i 		the i_th daughter of the named node
\>-i 	the i_th daughter, counting from the 		right, of the named node.

## 移动节点
move <name> <position>  将命名节点移动到制定位置
VP < (/^WH/=wh $++ /^VB/=vb) // 以WH开头和以VB开头
move vb $+ wh

## 合并

adjoin <auxiliary_tree> <name>
而且目标位置节点的子节点也会成为 foot的子节点
adjoin (VP (ADVP (ADV usually)) VP@) vp                    VP@ 为foot
