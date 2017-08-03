CS75_Lab
========

[CS75 Principles of Compiler Design][1]是一门非常好的介绍编译器设计的课程，这位老师启发式的授课方法让我有很大收获。

作者将Reading和Video放在了[课程主页][1]上，将Lab和Notes放在了[github][2]上。

这个仓库存放了我的Lab的代码。

starter-adder
-------------
实现Adder这个语言，Adder能定义变量，提供一元操作符。

- 具体语法，程序员需要按照语法要求写程序
- 抽象语法，用数据结构表示的，面向编译器的，用于表达程序员写的程序
- 语义，描述抽象语法的行为，所以编译器知道这些代码是做什么的。

相关定义看project里的README

project提供了词法分析和语法分析，需要写的代码在compile.ml中，函数的输入是`expr`，输出一列汇编指令。

分为两个步骤，1是
```
compile : expr -> instruction list
```
通过该函数完成表达式到指令序列的转换，上述函数签名不够准确，为了支持本地变量，仍需要引入栈，以及记录变量在栈中的位置。在转换的过程中，只有`Let(binds, body)`略微麻烦，这里bings的定义为(string * expr) list，意味着let后面可以跟很多个bings，为了解决list，使用类似fold的思想，引入`helper`函数方便尾递归，注意递归调用时acc，stack_index和env的相应变化。

```
Let(binds, body) ->
        (let rec helper(binds,body, acc, stack_index, env) = 
          match binds with
          | [] -> acc @ compile_env body stack_index env
          | (str, expr)::x' ->
              helper(x', body, acc@(compile_env expr stack_index env)@[IMov(RegOffset(stack_index * 4, ESP), Reg(EAX))], stack_index+1, ([str,stack_index]@env))
        in helper(binds,body, [], stack_index, env))
```

2是
```
to_asm_string : instruction list -> string
```
该函数把指令序列转换成string类型，instruction是程序中定义的类型，做个匹配转换成汇编的格式即可。

starter-boa
-----------
相比上一个proj，这个在语法上加入了二元操作，和分支语句。同时在expr转换为汇编指令序列的时候，加入了一个中间步骤，即先将expr转化为[A-Normal Form][3]，再转换为指令序列，这样做能使得二元操作编译起来更加简单。为了实现分支，加入了新的指令`jmp`。

[1]: https://www.cs.swarthmore.edu/~jpolitz/cs75/s16/
[2]: https://github.com/compilers-course-materials
[3]: http://matt.might.net/articles/a-normalization/