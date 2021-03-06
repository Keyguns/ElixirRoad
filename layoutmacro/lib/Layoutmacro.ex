# ExUnit.start()
# use ExUnit.Case, async: true
defmodule Rebuildmacro do
    defmacro layout(module_name,do: clause) do
      {:__block__,[],message_list} = clause
      # 通过AST获取信息 还是太darty了
      # 得到message的信息，
      messages = Enum.map(message_list,fn message -> get_argue(message)end)
      funcs    = Enum.map(messages,    fn message -> compose_arguement(message) end)
     
      quote do 
        ExUnit.start()
        defmodule unquote(module_name) do
          use ExUnit.Case, async: true
          unquote(funcs)
        end
      end  
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
    layout Haha do
      message("Happy ","hungry")
      message("Mad ","thirsty")
      message("Bored ","fully")
    end
  end  