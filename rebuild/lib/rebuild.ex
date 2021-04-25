defmodule Rebuild do

### defcase  
  defmacro defcase(module_name, do: case_block) do
    quote do
      defmodule unquote(module_name) do
        @moduledoc false
        use ExUnit.Case, async: true
        # import 无需处理直接展开即可
        unquote(case_block)
      end
    end
  end

  defmacro bizflow(bizflow_name, do: clause) do
    quote do
      test unquote(bizflow_name) do
        unquote(clause)
      end
    end
  end

  defmacro message(actor, {usecase_name, _, _}) do
    {usecase_name, [], [{actor, [], []}]}         # 将biz的原子专成函数函数调用
  end

### defactor
  defmacro defactor(module_name, do: clause) do
    quote do
      defmodule unquote(module_name) do
        ExUnit.start()
        use ExUnit.Case, async: true
        import Eval.Module
       
        unquote(clause)
      end
    end
  end

  defmacro actor(actor, {username, password}) do
    quote do
      def unquote(actor)(), do: %{login_name: unquote(username), password: unquote(password)}
      # IO.inspect("hahaha")
    end
  end

  defmacro defusecase({func_name, _, [actor]}, do: clause) do
    quote do
      def unquote(func_name)(unquote(actor)) do     
        import Kernel,except: [==: 2]
        unquote(clause)
        # clause 处理AST 吧 
      end
    end
  end
### definterface()
### Rebuild definterface
  defmacro definterface(test_module_name,do: clause)do
    quote do
      defmodule unquote(test_module_name) do
        unquote(clause)
      end
    end
  end

  defmacro interface(invoked_func,{func,_,_}) do
    quote do
      def unquote(invoked_func)(),do: %{biz: gen_biz(__MODULE__),func: unquote(func)}
    end
  end

  def gen_biz(test_module_atom) do
    test_module_string = to_string(test_module_atom)
    test_module_list   = String.split(test_module_string,".")

    module_name = deal_prefix(test_module_list)   
    # module_name = test_module_list -- ["Test"] 
    module_name = Enum.join(module_name,".")
    String.to_atom("Elixir."<>module_name)  
  end
  
  def deal_prefix([first|module_name]) when first == "Test" do
    module_name
  end 

  def deal_prefix([_first|rest]),do: deal_prefix(rest)
end

defmodule Eval.Module do  
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
