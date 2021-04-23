# now start
# 简化命名结构 definterface 取名为 Test.<>.被测Biz
# 更像是一个框架 Junit

# testmodule 和 biz 之间建立关系
defmodule ModuleName do
  defmacro definterface(test_module_name,do: clause)do
    quote do
      defmodule unquote(test_module_name) do
        unquote(clause)
      end
    end
  end

  defmacro interface(invoked_func,{func_name,_,_}) do
    quote do
      unquote(invoked_func)(),do: %{biz: gen_module(__MODULE__) ,func: func_name}
    end
  end

  def gen_module(test_moduel_name) do
    
  end


end





"""

definterface Test.A.B.C  do
  interface(:invoked_func,func_name)
end

defmodule Test.A.B.C do
# @invoked_func %{biz: invoked_func,func: func_name}
  invoked_func(),do: %{biz: invoked_func,func: func_name}

end

"""

# defmodule Test.ModuleName.A.B do
# impoort  # MODUlE 是__ENV__的 ShortCut

#   IO.inspect(__MODULE__)

#   module_name = __MODULE__
#   module_name = gen_module(module_name)
#   IO.inspect(module_name)
# end

# defmodule Generater do
#   def gen_module(module_name) do

#   end
# end



### Don't want to coding
