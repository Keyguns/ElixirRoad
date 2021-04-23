defmodule Rebuild do
### defactor
  defmacro defactor(module_name, do: clause) do
    quote do
      defmodule unquote(module_name) do
        ExUnit.start()
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

    test_module_list = deal_prefix(test_module_list)   

    module_name = test_module_list -- ["Test"] 
    module_name = Enum.join(module_name,".")
    String.to_atom("Elixir."<>module_name)  
  end
 
  def deal_prefix([first|rest]) when first == "Test" do
    [first]++rest
  end 

  def deal_prefix([first|rest]),do: deal_prefix(rest)
end

