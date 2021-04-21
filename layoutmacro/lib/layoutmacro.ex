# ExUnit.start()
# use ExUnit.Case, async: true
defmodule Layoutmacro do
  defmacro layout(module_name,do: clause) do
    {:__block__,[],message_list} = clause
    messages = Enum.map(message_list,fn message ->
      {_,_,[emotion,status]} = message
      {emotion,status}
    end)

    funcs = Enum.map(messages,fn message -> quote do assert message(unquote(message)) end end)

    quote do
      ExUnit.start()
      defmodule unquote(module_name) do
        use ExUnit.Case, async: true
        unquote (funcs)
      end
    end
  end


  def message({emotion,status}) do
    IO.inspect(emotion<>status)
  end

end

defmodule Run do
  import Layoutmacro
 
  layout Haha do
    message("Happy ","hungry")
    message("Mad ","thirsty")
    message("Bored ","fully")
  end
end
  
  # expr = 
  # quote do 
  #   layout Haha do
  #     message("Happy ","hungry")
  #     message("Mad ","thirsty")
  #     message("Bored ","fully")
  #   end
  # end
  # res = Macro.expand_once(expr,__ENV__)
  # IO.puts(Macro.to_string(res))


# 函数调用宏
