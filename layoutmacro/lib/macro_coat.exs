### 参数列表中的元素和宏的参数进行pattern match
### 属实简单，一天半的时间没有解决
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
end

### func version 
defmodule FuncLib do
  def message_fun(emotion,status) do
    IO.inspect(emotion<>status)
  end
end

defmodule Run do
  import Coat
  
  coat ModuleName do 
    import FuncLib
    message_fun("happy","hungry")
    message_fun("angry","thirsty")
    message_fun("sad","hungry and thirsty")
  end
end