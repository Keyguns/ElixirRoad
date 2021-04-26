defmodule Yzd.Dsl.Usecase do
  @moduledoc false

  alias Yzd.Dsl.Usecase.Parse, as: P

  defmodule Error do
    defexception message: nil
  end

  ### defcase
  defmacro defcase(module_name, do: case_block) do
    quote do
      defmodule unquote(module_name) do
        @moduledoc false
        use ExUnit.Case, async: true
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
    # 将bizcase的原子转换成函数函数调用
    {usecase_name, [], [{actor, [], []}]}
  end

  ### defactor

  defmodule Eval.ForUsecase do
    @moduledoc "use macro rebuild the == for usecase "
    defmacro assert_message == message do
      quote do
        resp = unquote(message)
        assert unquote(assert_message) == resp
      end
    end
  end

  defmacro defactor(module_name, do: clause) do
    quote do
      ExUnit.start()

      defmodule unquote(module_name) do
        use ExUnit.Case, async: true
        import Eval.ForUsecase
        import Kernel, except: [==: 2]
        unquote(clause)
      end
    end
  end

  defmacro actor(actor, {username, password}) do
    quote do
      def unquote(actor)(), do: %{login_name: unquote(username), password: unquote(password)}
    end
  end

  defmacro defusecase({func_name, _, [actor]}, do: clause) do
    quote do
      def unquote(func_name)(unquote(actor)) do
        # import Kernel, except: [==: 2]
        unquote(clause)
      end
    end
  end

  defmacro message(inv_inter, para_list) when is_list(para_list) do
    quote do
      apply(
        unquote({inv_inter, [], []}).biz,
        unquote({inv_inter, [], []}).func,
        unquote(para_list)
      )
    end
  end

  ### definterface
  defmacro definterface(test_module_name, module_name, do: block) do
    interfaces = P.parse_interface(block)
    module_name = P.parse_module_name(module_name)

    interfaces =
      Enum.map(
        interfaces,
        fn interface ->
          int_name = interface.inter
          func_name = interface.func

          quote do
            def unquote(int_name)(), do: %{biz: unquote(module_name), func: unquote(func_name)}
          end
        end
      )

    quote do
      defmodule unquote(test_module_name) do
        unquote(interfaces)
      end
    end
  end
end

defmodule Yzd.Dsl.Usecase.Parse do
  @moduledoc "parse the block"

  def parse_interface({:__block__, _, int_lines}) when is_list(int_lines) do
    do_parse_interface(int_lines, [])
  end

  def parse_interface(item) do
    do_parse_interface([item], [])
  end

  defp do_parse_interface([], interfaces) do
    interfaces
  end

  defp do_parse_interface([{keyword, _, [int_name, {func_name, _, _}]} | rest], interfaces)
       when is_atom(int_name) and keyword == :interface do
    interface = %{
      inter: int_name,
      func: func_name
    }

    do_parse_interface(rest, [interface | interfaces])
  end

  defp do_parse_interface(_, _) do
    raise Yzd.Dsl.Usecase.Error, "invalid block"
  end

  def parse_module_name({_, _, module_name}) do
    module_name = Enum.join(module_name, ".")
    module_name = "Elixir." <> module_name
    String.to_atom(module_name)
  end
end
