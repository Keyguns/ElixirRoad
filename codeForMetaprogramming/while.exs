defmodule Loop do 
  defmacro while(expression,do: block)do
    quote do
      for _<- Stream.cycle([:ok])do
        if unquote(expression) do
          unquote(block)
        else
        end
      end 
    end
  end
end


# message 函数形式呈现 Macro中的function
