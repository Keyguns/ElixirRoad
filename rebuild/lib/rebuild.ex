defmodule Rebuild do
  # defactor
  defmacro defactor(module_name, do: clause) do
    quote do
      defmodule unquote(module_name) do
        ExUnit.start()
        unquote(clause)
      end
    end
  end

  # 忽略属性 帮助不大
  defmacro actor(actor, {username, password}) do
    quote do
      def unquote(actor)(), do: %{login_name: unquote(username), password: unquote(password)}
      # IO.inspect("hahaha")
    end
  end

  defmacro defusecase({func_name, _, [actor]}, do: clause) do
    quote do
      def unquote(func_name)(actor) do
        unquote(clause)
        # clause 处理AST 吧
      end
    end
  end

  defmacro definterface(test_module_name,_module_name,do: clause)do
    quote do
      defmodule unquote(test_module_name) do
        unquote(clause)
      end
    end
  end

  defmacro definterface(invoked_func,func) do
    quote do
      def unquote(invoke_func)(),do: %{biz: gen_biz(__MODULE__),func: func}
    end
  end

end
