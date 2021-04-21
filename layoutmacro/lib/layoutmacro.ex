# ExUnit.start()
# use ExUnit.Case, async: true
defmodule Layoutmacro do
  defmacro layout(module_name,do: clause) do
    {:__block__,[],message_list} = clause

    # 得到message的信息，
    messages = Enum.map(message_list,fn message ->
      {_,_,[emotion,status]} = message
      {emotion,status}
    end)

    funcs = Enum.map(messages,fn message -> quote do assert func_message(unquote(message)) end end)
    [fun1,fun2,fun3] = funcs
    quote do
      ExUnit.start()
      defmodule unquote(module_name) do
        use ExUnit.Case, async: true
        unquote (fun1)
        unquote (fun2)
        unquote (fun3)
        #unquote(funcs)
      end
    end

  end


  def func_message({emotion,status}) do
    IO.inspect(emotion<>status)
    IO.inspect("DayDayUp")
  end

end

defmodule Run do
  import Layoutmacro

# 查看扩展函数结果
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

  layout Haha do
    message("Happy ","hungry")
    message("Mad ","thirsty")
    message("Bored ","fully")
  end
end



# 函数调用宏
