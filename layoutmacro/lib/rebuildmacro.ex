# ExUnit.start()
# use ExUnit.Case, async: true
defmodule Rebuildmacro do
  defmacro layout(module_name,do: clause) do
    {:__block__,[],message_list} = clause

    # 得到message的信息，
<<<<<<< HEAD:layoutmacro/lib/layoutmacro.ex
    messages = Enum.map(message_list,fn message ->
      {_,_,[emotion,status]} = message
      {emotion,status}
    end)

    funcs = Enum.map(messages,fn message -> quote do assert func_message(unquote(message)) end end)
    [fun1,fun2,fun3] = funcs
    quote do
=======
    messages = Enum.map(message_list,fn message -> get_argue(message)end)
    funcs    = Enum.map(messages,    fn message -> compose_arguement(message) end)
    [fun1,fun2,fun3] = funcs  #push from list 
    quote do 
>>>>>>> 171f840dd61458236273777060a9cf91ff5b8dd9:layoutmacro/lib/rebuildmacro.ex
      ExUnit.start()
      defmodule unquote(module_name) do
        use ExUnit.Case, async: true
        unquote (fun1)
        unquote (fun2)
        unquote (fun3)
      end
<<<<<<< HEAD:layoutmacro/lib/layoutmacro.ex
    end

=======
    end  
>>>>>>> 171f840dd61458236273777060a9cf91ff5b8dd9:layoutmacro/lib/rebuildmacro.ex
  end

  defp compose_arguement(message)do
    quote do 
      assert func_message(unquote(message)) 
    end
  end 

  def func_message({emotion,status}) do
    # 这种形式具备更好的扩展性
    IO.inspect(emotion<>status)
    IO.inspect("DayDayUp")
  end
  def get_argue(message) do
    {_,_,[emotion,status]} = message
    {emotion,status}
  end 

  def showAST(expr) do
    res = Macro.expand_once(expr,__ENV__)
    IO.puts(Macro.to_string(res))
  end
end

defmodule Run do
  import Layoutmacro
<<<<<<< HEAD:layoutmacro/lib/layoutmacro.ex

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
=======
>>>>>>> 171f840dd61458236273777060a9cf91ff5b8dd9:layoutmacro/lib/rebuildmacro.ex

  layout Haha do
    message("Happy ","hungry")
    message("Mad ","thirsty")
    message("Bored ","fully")
  end
end


