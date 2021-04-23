### 参数列表中的元素和宏的参数进行pattern match

defmodule Coat do
  defmacro coat(module_name,do: clause) do
    IO.inspect("A")
    quote do
      defmodule unquote(module_name) do
        unquote(clause)    
      end    
    end
  end

### macro version
  defmacro message(emotion,status)do
    IO.inspect("B")
    quote do
      IO.inspect(unquote(emotion)<>unquote(status))
    end
  end 

  defmacro invoke_func({func_name,_,_},actor)do
    {func_name,[],[actor]}
  end


### func version 
  def message_fun(emotion,status) do
    IO.inspect(emotion<>status)
  end
end

# 函数还是面向的是结果，macro面向的是生成的代码

defmodule FuncLib do
  def func_1(actor),do: IO.inspect(actor,label: "func_1")
  def func_2(actor),do: IO.inspect(actor,label: "func_2")
end

defmodule Run do
  import Coat
  
  coat ModuleName do 
    import FuncLib
    message_fun("happy","hungry")
    message_fun("angry","thirsty")
    message_fun("sad","hungry and thirsty")
    invoke_func(func_1,"Ben")          # 搞定了
    invoke_func(func_2,"LaDen")
  end
end