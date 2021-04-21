defmodule Layoutmacro do
  defmacro layout(module_name,do: clause) do
    {:__block__,[],message_list} = clause
    Enum.map(message_list,fn message ->
      {_,_,[emotion,status]} = message
      
    end)
    quote do
      defmodule unquote(module_name) do

      end
    end
  end


end

defmodule Run do
  import Layoutmacro
  layout Boring do
    message("Happy","hungry")
    mess
    message("Angry","thirsty")
  end
end





# 函数调用宏
