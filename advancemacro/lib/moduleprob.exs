# == > solve the interface biz content problem
# 宏是卫生的
# __MODULE__ 获取模块名，列表处理

defmodule InterfaceBiz do
  defmacro definterface(test_module_name,module_name,do: clause) do
    quote do
      defmodule unquote(test_module_name) do
        IO.inspect(__MODULE__,label: "MacroModule")
        IO.inspect __MODULE__
        unquote(clause)
      end
    end
  end

  defmacro interface(invo_func,_func_name)do
    IO.inspect(Kernel.var!(__MODULE__)) # 定义Macros'__MODULE__属性
    biz_name = __MODULE__
    quote do
      IO.inspect(__MODULE__,label: "invoke in injection")
      def unquote(invo_func)(),do: %{biz: unquote(biz_name),func: unquote(:func_name)}
    end
  end
end


defmodule Run do
  import InterfaceBiz 
  
  definterface Test.A.B , A.B do 
    interface(:haha,happy)   
  end
end

defmodule Mod do
  defmacro definfo do
    IO.puts "In macro's context (#{__MODULE__})"    # IO.定义时所在module
    quote do
      IO.puts "In caller's context (#{__MODULE__})" # 注入时所在Module
      def friendly_info do
        # 调用时所在Module
        IO.puts """
        My name is #{__MODULE__}  
        """
      end
    end
  end
end

defmodule MyModule do
  require Mod
  Mod.definfo
end  
