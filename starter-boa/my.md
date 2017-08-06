这个实验主要是实现表达式向A-Normal Form的转换

作者想告诉我们什么？

- 将AST转化成A-Normal Form的形式
 * A-Normal Form是什么？
 		- 也是一种代码的内部表示，只是将表达式分割成了原子表达式和复杂表达式两种
 * 为什么要转？
 		- 非常简单的生成机器码，也容易构造分析器，比如有一个复杂表达式(5+3)-2，直接在AST上计算怎么计算？要考虑子表达式的中间结果吧。使用ANF就省略了这个问题。  

经过调整，给出了如下形式的ANF的定义，接下来要考虑如何从expr转过去。

```
type immexpr =
  | ImmNumber of int
  | ImmId of string

and cexpr =
  | CPrim1 of prim1 * immexpr
  | CPrim2 of prim2 * immexpr * immexpr
  | CIf of immexpr * aexpr * aexpr
  | CImmExpr of immexpr

and aexpr =
  | ALet of string * cexpr * aexpr
  | ACExpr of cexpr
```

给出anf_k的实现，函数可以认为是输入一个表达式expr，一个函数k，该函数输入immexpr得到aexpr，最后返回aexpr。函数调用时`anf_k e (fun imm -> ACExpr(CImmExpr(imm)))`。
	
- 对于ENumber(n)和EId(name)，直接调用k返回即可
- 对于一元操作EPrim1(op，e)，递归调用了anf_k，其中k函数返回了一个ALet形式的aexpr，这也很好理解，因为是一元操作，所以改成let绑定的形式，在上面进行操作。
- 对于EPrim2(op, left, right)，首先应该想到用递归处理left和right，但是不能分开处理，因为写成aexpr时候有一个上下文的约束，分开处理便忽略了上下文，于是采用如下的递归形式，注意最后返回的时候不能直接写成`CPrim2(op, limm, rimm)`，这会导致信息损失。
- ELet是空出来的部分，要自己写上，思路就是对前面的binds要递归展开，最后加上body，于是我采用了一个辅助函数helper，如果binds为空，直接对body操作，否则，取出头元素，处理之后递归访问剩下的。举个例子看一下就比较好写了。
- EIf相比EPrim2来说比较好写，因为两个分支之间没有上下文关系。



```
let rec anf_k (e : expr) (k : immexpr -> aexpr) : aexpr =
  match e with
    | EPrim1(op, e) ->
      let tmp = gen_temp "unary" in
      anf_k e (fun imm -> ALet(tmp, CPrim1(op, imm), k (ImmId(tmp))))
    | ELet(binds, body) ->
      (let rec helper bs bdy = 
        match bs with
        | [] -> (anf_k bdy k)
        | (str,expr)::x' -> (anf_k expr (fun immval -> 
            ALet(str, CImmExpr(immval), (helper x' bdy))))
      in helper binds body)
    | EPrim2(op, left, right) ->
      let tmp = gen_temp "unary" in
      anf_k left (fun limm 
        -> anf_k right (fun rimm ->
          ALet(tmp, CPrim2(op, limm, rimm), (k (ImmId(tmp))) )))
    | EIf(cond, thn, els) ->
      let tmp = gen_temp "if" in
      let ret = (fun imm -> ACExpr(CImmExpr(imm))) in
      anf_k cond (fun immcond ->
        ALet(tmp, CIf(immcond, anf_k thn ret, anf_k els ret), (k (ImmId(tmp)))))
    | ENumber(n) ->
      (k (ImmNumber(n)))
    | EId(name) ->
      (k (ImmId(name)))
```
      
有了上面的转化之后后面的向汇编指令序列转换的操作就好写多了。
