# showASTbyMacro
defmodule Demo0415 do

  def hello do
    :world
  end

  defmacro show_null(module_name,do: block) do
    IO.inspect(block,label: "null body")  # IO.inspect() 不返回label中的内容
  end

  defmacro show(module_name,do: clause) do 
    IO.inspect(module_name)
    IO.inspect(clause)
    quote do 
      defmodule unquote(module_name) do
        def testmodule do
          IO.puts("ezay module name")
        end
      end
    end
  end
end

#module name 名称处理

#import __block__ 参数列表中的第一个
#do ... end     作为一个参数 
#,do:           空作为两个参数
#,do: sentence  作为一个参数
defmodule Run do
  import Demo0415

  show_null SimpleBody,do: IO.inspect("haha")

  show_null NullbodyModule do
    import A
    
  end
  show EazyModuleName do
    import A
    A.out
    IO.inspect("hello show_macro")
    IO.inspect("two sectence")
  end
  
  EazyModuleName.testmodule()

  show Haha do
    IO.inspect("one sentence")
  end
end

defmodule A do
  def out do
    IO.inspect("I am module A")
  end
end



