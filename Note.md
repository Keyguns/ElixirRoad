--------------------------------155
#### 0413
- import Module
模块如果不使用会有异常
- 调用函数匹配不到会报错
FunctionClauseError
- list-pipe
- 函数不匹配不处理
- [a]=[] 空列表无法和列表中的变量进行匹配
- 空函数返回值为nil
#### 0415
- 可以通过在macro中输出代码块，查看AST 
- do ... end ==> 转成AST [do: {:__block__,[...],[...]}] —— do...end 中多条语句
  do ... end ==> 转成AST [do: {AST}]
- 将语句列表注入到AST参数列表 解决生成部分嵌套在列表中
#### 0416
- Nullbody可以通过编译
- import ××名称问题××
``` elixir
 import 模块名如果与所属模块名有重叠会导致import的模块名根据所属模块外层名称展开
 V import Test.Bizcase.Import ==> import Run.Test.Bizcase.Import 
 defmodule Run do
   defmodule Test.Fuck do
     #   @moduledoc(false)
     #   use(ExUnit.Case, async: true)
       import Test.Bizcase.Import
   end
 end
```
#### 0419
- ** (CompileError) test/dsl/usecase_test.exs: invalid arguments for "try"
  AST合成出现问题报错
- 代码报错就按照逻辑走判断是否出现问题
- module 和 function 变量 名字都是原子类型
- 调用宏和调用函数的AST都一样
