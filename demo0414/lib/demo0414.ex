# Escape 

defmodule Exp do
  def escape_function do 
    a = 12
    b = 256
    a + b
  end
  def haha do
   
  end
  
end

defmodule Run do
  
  IO.inspect('-----------------------------------------')
  IO.inspect(quote do
    def approve_stockin(actor) do
    resp = apply(Test.A.B.ac_signin.biz, Test.A.B.ac_signin.func, [actor.loginname, actor.password])
    assert resp == :ok
    
    resp = apply(Test.A.B.si_getlist.biz, Test.A.B.si_getlist.func, [10, 0, 0, 0])
    assert resp == {:ok, :ok}
    end
  end)
  IO.inspect(Exp.haha) # 函数没有函数体返回值为nil
  
end
