# Read Metaprograming ELixir
### catelog
- Introductioin
- The language of Macros
- Extending Elixir with Metaprogramming 
- Advance Compile-Time Code Generation
- How to test Macros
- Creating an HTML Domain-Specific Language
- With Great Power Comes Great Responsibility

#### Note
learn not only all the metaprogramming tricks, but also the commonpitfalls   

How to read  
writing your own language features

Topic  
- Writing a test framework with macros  
- Generating functions from external datasets and remote APIs
- Properly testing your metaprogramming-based code
- code that write code  Elixir push

#### Two essential concepts of Elixir’s metaprogramming system 
- Jose Valim creater of elixir  
- Having the AST accessible by normal Elixir code do very powerful thing  
- beacause you can operate at the level typically reserved only for compilers and language designer  
- AST lets  you  infermeaning, optimize performance, or extend functionality while staying withinElixir’s high-level syntax
- Turn  you,  the  programmer,  fromlanguage consumer to language creator
-  José used towrite the standard library. He opened the language up for your own extension.Once you experience that level of power, it’s hard to go back
- Macro allow you to extends the language with your own keywords 
-  Elixir was designedwith extension in mind
- Macro improve proformance 

#### Macro
- macros allow you to extend the language
with your own keywords while using existing macros as building blocks.
- Macro Rules
1. Don't write Macros 
    taken too far, macros can makeprograms difficult to debug and reason about  
2. Use Macro Gratuitously

#### AST    

- deal with the struct problem
rely on this uniform breakdown when pattern matching
arguments in macros

-  how to transform the AST using Elixir’s macro system.
- more complex types are returned as a quoted expression to avoid confusion 
- quote && unquote
- show ast process
  - **Macro.expand_once** --- single times
  - **Macro.expand_fully** --- until meet the special macro need use expand_one to realise the func
  - **Code.eval_quoted** evaluate an AST
- hygiene 
  - ***var！***
  > allow our macro to produce an AST that has access to the caller’s bindings when expanded

> [do: "it's true", else: "it remains to be seen"]
> 关键字列表可以通过库函数进行获取



```elixir
quote do 
  haha haha_name do 
    IO.inspect(:Hello) 
  end 
end

{:haha, [],
 [
   {:haha_name, [], Elixir},
   [
     do: {{:., [], [{:__aliases__, [alias: false], [:IO]}, :inspect]}, [],
      [:Hello]}
   ]
 ]}
```

#### To DSL or Not to DSL
1. Can the domain be expressed naturally by macros in Elixir’s syntax, such
as HTML tags?  
2. Would a DSL cause the caller to think more or less about how to solve
their problem? (require the siutation fix )
3. Should I require users of my library to have all kinds of code injected into
their context?


#### Avoid Common Oitfalls
- Don't use when you can import
    - Import gives us everything we had in our previous solution which by __using__
- Avoid Injection Large Amount of Code
    - 
- 






### Keywords
- belt 腰带
- optimization 优化
- hazards 危害
- temptation 诱人
- parse 解析
- pattern matched 模式匹配
- temper behavior 磨练能力
- irresponsible 不负责任
- duality 二元性
- dispel 打消
- preconceived 先入为主
- demystified 神秘话
- work our way up 努力工作
- nested 嵌套
- AST Abstract Syntax Tree
- literals 文字
- lay 铺设，放置，躺下
- ties 联系
- fumblle 摸索
- encounter 遇到
- invocation 调用
- explicit 显性
- violating 违反
- clobbered 破坏
- basis 基础
- eliminate 清除
- boilerplate 样板
- spawns 产生
- repeatedly 反复
- wrapped 包裹
