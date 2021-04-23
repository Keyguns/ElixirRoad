### 参数列表中的元素和宏的参数进行pattern match
### 最终效果吧
defmodule Coat do
  defmacro coat(module_name,do: clause) do
    IO.inspect("A")
    quote do
      defmodule unquote(module_name) do
        unquote(clause)    
      end    
    end
  end

### func
  defmacro message(emotion,status)do
    IO.inspect("B")
    quote do
      IO.inspect(unquote(emotion)<>unquote(status))
    end
  end 
end

defmodule FuncLib do
  
end

defmodule Run do
  import Coat
  
  coat ModuleName do 
    import FuncLib
    message("happy","hungry")
    message("angry","thirsty")
    message("sad","hungry and thirsty")
  end
end