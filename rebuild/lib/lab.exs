defmodule Mess do

  defmacro assert_message == message do
    quote do 
      resp = unquote(message)
      assert unquote(assert_message) == resp
    end
  end

  defmacro user_message(inv_inter,para_list) do
    quote do 
      apply(
            unquote({inv_inter,[],[]}).biz,
            unquote({inv_inter,[],[]}).func,
            unquote(para_list)
            )
    end
  end
  
end


## 必须通过原子构造函数头
defmodule Invoked do
  def fun_name1(_,_,_) do
    :ok
  end 
  def fun_name2() do
    IO.inspect("Haha")
  end
end

defmodule Test.Inter.ForInvoke do
  def get_func(),do: %{biz: Invoked,func: :fun_name1}
end


ExUnit.start()
defmodule Run do
  use ExUnit.Case
  import Test.Inter.ForInvoke
  import Kernel,except: [==: 2]
  import Mess
  
  :ok == user_message(:get_func,[1,2,3])
  
end

# ==> context问题
# => 通过限制作用域解决