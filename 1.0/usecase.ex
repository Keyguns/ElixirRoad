defmodule Yzd.Dsl.Usecase do
  @moduledoc false

  alias Yzd.Dsl.Usecase.Parser, as: P
  alias Yzd.Dsl.Usecase.Generator, as: G

  defmodule Error do
    defexception message: nil
  end

  # 处理思路和use case类似
   

  # actor(:c1o, {"company1operator@justkey.net", "774411"})
  # @c1o %{loginname: "company1operator@justkey.net", password: "774411"}

  # interface(:actor_func,fun_name)
  # @int_name %{biz: module_name,func: func_name}

  defmacro defactor(module_name, do: block) do
    # actors = [%{name: <actor_name>, loginname: <loginname>, password: <password>, module_name: <module_name>},  ]

    # 一步到位
    {def_import, actors_ast, defusecases} = P.parse(block)

    actors =
      Enum.map(actors_ast, fn actor ->
        # 很巧妙的地方将属性值转成AST 便于后面传参
        value = Macro.escape(%{login_name: actor.login_name, password: actor.passwd})
        name = actor.name

        quote do
          # @c1o %{loginname: "company1operator@justkey.net", password: "774411"}
          # def c2o(), do: @c2o
          # 返回属性 AST      ==》   注入后成为属性
          unquote(G.gen_attr(name, value))
          # 最后返回一个 “单元格” 回列表
          def unquote(name)(), do: unquote(P.expose_attr(name))
        end
      end)

    # IO.puts("defusecases")
    # IO.puts(Macro.to_string(defusecases))

    quote do
      ExUnit.start()

      defmodule unquote(module_name) do
        use ExUnit.Case, async: true
        # import interface module
        unquote(def_import)
        # 此时的actor已经是由多行组成的table
        unquote(actors)
        # actors 中包括属性和函数
        unquote(defusecases)
        # 展开defuscase (AST)
      end
    end
  end

  defmacro definterface(test_module_name, module_name, do: block) do
    interfaces = P.parse_interface(block)
    # "Elixir." <> module_name
    module_name = P.parse_module_name(module_name)
    # {inter: int_name,func： func_name}
    interfaces =
      Enum.map(
        interfaces,
        fn interface ->
          int_name = interface.inter
          func_name = interface.func
          attr_value = Macro.escape(%{biz: module_name, func: func_name})

          quote do
            unquote(G.gen_int_attr(int_name, attr_value))
            # exposure function
            def unquote(int_name)(), do: unquote(P.expose_attr(int_name))
          end
        end
      )

    # @int_name %{biz: moudle_name,func: func_name}
    # 展开 definterface
    quote do
      defmodule unquote(test_module_name) do
        unquote(interfaces)
      end
    end
  end
end

defmodule Yzd.Dsl.Usecase.Generator do
  @moduledoc false
  def gen_attr(name, value) when is_atom(name) do
    # 巧妙之处在于用AST作为参数构造AST
    {:@, [], [{name, [], [value]}]}
  end

  def gen_attr(_other_name, _other_value), do: raise(Yzd.Dsl.Usecase.Error, "name should be atom")

  def gen_int_attr(int_name, attr_value) when is_atom(int_name) do
    {:@, [], [{int_name, [], [attr_value]}]}
  end

  def gen_int_attr(_other_name, _other_value),
    do: raise(Yzd.Dsl.Usecase.Error, "name should be atom")

  # 将函数语句（列表）注入到函数AST中(参数列表)
  # 没有函数体的函数
  def gen_func(func_name, actor, nil) do
    {:def, [], [{func_name, [], [actor]}, [do: {:__block__, [], []}]]}
  end

  # 有函数体的函数  解决列表嵌套点睛之笔    一个也进代码块？
  def gen_func(func_name, actor, messages) do
    {:def, [], [{func_name, [], [actor]}, [do: {:__block__, [], messages}]]}
  end
end

defmodule Yzd.Dsl.Usecase.Parser do
  @moduledoc false
  # actors = [%{name: <actor_name>, loginname: <loginname>, password: <password>, module_name: <module_name>},  ]

  defmacro invoke_func_by_atom(func_name) do
    {func_name, [], []}
  end

  @allowed_keywords [:actor, :interface]
  def parse(block) do
    {def_import, block} = parse_import(block)
    {actors_ast, block} = parse_actor(block)
    defusecases = parse_defusecase(block)
    {def_import, actors_ast, defusecases}
  end

  def parse_actor({:__block__, _, lines}) when is_list(lines) do
    do_parse_actor(lines, [])
  end

  def parse_actor(item) do
    # 制造列表
    do_parse_actor([item], [])
  end

  # 操作列表 返回列表
  defp do_parse_actor([{keyword, _, [name, {login_name, passwd}]} | rest], actors)
       when is_atom(name) and keyword in @allowed_keywords do
    actor = %{
      name: name,
      login_name: login_name,
      passwd: passwd
    }

    do_parse_actor(rest, [actor | actors])
  end

  # 管道符尾部制造一个列表
  defp do_parse_actor([[{keyword, _, [name, {login_name, passwd}]} | rest]], actors)
       when is_atom(name) and keyword in @allowed_keywords do
    actor = %{
      name: name,
      login_name: login_name,
      passwd: passwd
    }

    do_parse_actor(rest, [actor | actors])
  end

  defp do_parse_actor(block, actors) do
    {actors, block}
  end

  # 通配符的告警过于宽泛
  # defp do_parse_actor(_, _) do
  #   raise Yzd.Dsl.Usecase.Error, "invalid block"
  # end

  # int_lines--interface_row
  def parse_interface({:__block__, _, int_lines}) when is_list(int_lines) do
    do_parse_interface(int_lines, [])
  end

  def parse_interface(item) do
    do_parse_interface([item], [])
  end

  # {:interface, [], [:userA1, {:getlist, [], Elixir}]}

  defp do_parse_interface([], interfaces) do
    interfaces
  end

  # interface(:si_getlist, getlist)
  # deal with block make hashmap for gen
  defp do_parse_interface([{keyword, _, [int_name, {func_name, _, _}]} | rest], interfaces)
       when is_atom(int_name) and keyword in @allowed_keywords do
    interface = %{
      inter: int_name,
      # biz: module_name,
      func: func_name
    }

    do_parse_interface(rest, [interface | interfaces])
  end

  defp do_parse_interface(_, _) do
    raise Yzd.Dsl.Usecase.Error, "invalid block"
  end

  #
  def parse_module_name({_, _, module_name}) do
    module_name = Enum.join(module_name, ".")
    module_name = "Elixir." <> module_name
    String.to_atom(module_name)
  end

  # exposures' function body , use for building actor and interface exposure function
  def expose_attr(attr_name) do
    {:@, [], [{attr_name, [], Elixir}]}
  end

  def parse_import({:__block__, _, clause}) do
    do_parse_import(clause, [])
  end

  # 只有一条import 模块体返回nil
  def parse_import({keyword, _, import_module})
      when keyword == :import do
    {{:import, [], import_module}, nil}
  end

  # 没有代码块存在 moudle 中有一条非import语句
  def parse_import(clause) do
    {nil, clause}
  end

  # 存在 import
  # {{keyword, [], def_import}, rest}

  def do_parse_import([{keyword, _, def_import} | rest], imports) when keyword == :import do
    do_parse_import(rest, [{keyword, [], def_import} | imports])
  end

  def do_parse_import(rest, imports) when imports != [] do
    {imports, rest}
  end

  # without import
  def do_parse_import(clause, _) do
    {nil, clause}
  end

  # defusecase 没有的状态
  def parse_defusecase([]) do
    nil
  end

  def parse_defusecase(clause), do: do_parse_defusecase(clause, [])

  # 一次获取一个 defusecase
  def do_parse_defusecase([{keyword, _, usecase_body} | rest_messages], defuscases)
      when keyword == :defusecase do
    [{func_name, _, [actor]}, messages_ast] = usecase_body
    messages = parse_message(messages_ast)
    # prepare for function  body

    # super function gen_func
    func = Yzd.Dsl.Usecase.Generator.gen_func(func_name, actor, messages)
    do_parse_defusecase(rest_messages, [func | defuscases])
  end

  # 返回defusecase
  def do_parse_defusecase([], defusecases), do: defusecases
  def parse_message(do: {:__block__, [], []}), do: nil

  def parse_message(do: message_ast) do
    # {_,_,message_list} = message_ast
    do_parse_message(message_ast)
  end

  def do_parse_message({keyword, [], message_list})
      when keyword == :__block__ do
    message_info = do_message_info(message_list, [])
    do_message_apply(message_info, [])
  end

  def do_parse_message(message_item) do
    message_info = do_message_info(message_item, [])
    do_message_apply(message_info, [])
  end

  # 处理每一条message （递归）
  def do_message_info([], message_info) do
    message_info
  end

  def do_message_info({_, _, message_assert}, _) do
    [assert_content | message_arg_ast] = message_assert
    [{_, _, message_arg}] = message_arg_ast
    [actor_int, parameter] = message_arg
    [{assert_content, actor_int, parameter}]
  end

  def do_message_info([{_, _, message_assert} | rest_messages], message_info) do
    [assert_content | message_arg_ast] = message_assert
    [{_, _, message_arg}] = message_arg_ast
    # actor 没有用
    [actor_int, parameter] = message_arg
    do_message_info(rest_messages, [{assert_content, actor_int, parameter} | message_info])
  end

  # :ok         = message(actor, :ac_signin,  [actor.loginname, actor.password])
  def do_message_apply([], apply_list) do
    apply_list
  end

  def do_message_apply([{assert_content, actor_int, parameter} | rest_info], apply_list) do
    {:__block__, [], [apply, assert]} =
      quote do
        resp =
          apply(
            unquote({actor_int, [], []}).biz,
            unquote({actor_int, [], []}).func,
            unquote(parameter)
          )

        # 解决了在不同module中通过原子调用func ^
        assert resp == unquote(assert_content)
      end

    do_message_apply(rest_info, [apply, assert | apply_list])
  end

  # bizflow

  def parse_case({:__block__, [], []}), do: {nil, nil}

  def parse_case(block) do
    # parse_import 处理 do ... end 代码头
    {def_import, clause} = parse_import(block)
    bizeflow_test = parse_bizeflow(clause)
    {def_import, bizeflow_test}
  end

  # 处理biflow有无
  def parse_bizeflow(nil), do: nil

  def parse_bizeflow(clause) do
    bizflow(clause, [])
  end

  def bizflow([], bizflow_tests), do: bizflow_tests

  def bizflow({keyword, _, [testflow_name, message_case]}, _)
      when keyword == :bizflow do
    assert_usecases = parse_biz_message(message_case)
    bizflow_test = {:test, [], [testflow_name, assert_usecases]}
  end

  def bizflow([{keyword, _, [testflow_name, message_case]} | rest_flows], bizflow_tests)
      when keyword == :bizflow do
    assert_usecases = parse_biz_message(message_case)
    bizflow_test = {:test, [], [testflow_name, assert_usecases]}
    bizflow(rest_flows, [bizflow_test | bizflow_tests])
  end

  # 多条message
  def parse_biz_message(do: {keyword, [], message_list})
      when keyword == :__block__ and message_list != [] do
    get_message_info(message_list, [])
  end

  # 一条或没有message
  def parse_biz_message(do: message_case), do: get_message_info(message_case)

  # 没有message
  def get_message_info({:__block__, [], []}), do: [do: {:__block__, [], []}]
  # 一条message
  def get_message_info({:message, _, message_info}) do
    [actor, {usecase_name, _, _}] = message_info
    # [do: {usecase_name, [], [actor]}]
    [do: message(actor, usecase_name)]
  end

  def get_message_info([], assert_usecases), do: [do: {:__block__, [], assert_usecases}]

  def get_message_info([{_, _, [actor, {usecase_name, _, _}]} | messages_rest], assert_usecases) do
    assert_usecase = message(actor, usecase_name)
    get_message_info(messages_rest, [assert_usecase | assert_usecases])
  end

  def message(nil, nil), do: nil

  def message(actor, usecase_name) do
    quote do
      assert unquote(usecase_name)(unquote({actor, [], []}))
    end
  end

  # message中 actor暴露函数作为参数
  # def func_message(actor, usecase_name) do
  #   quote do
  #     assert unquote(usecase_name)(unquote(actor))
  #   end
  # end
end

# {:message, [line: 33], [:c1o, {:apply_stockin, [line: 33], nil}]},
# {:message, [line: 34], [:c2o, {:apply_stockin, [line: 34], nil}]}

# {:assert, [line: 24], [{:func1, [line: 24], [:actor]}]},
# {:assert, [line: 25], [{:func2, [line: 25], [:haha]}]}

# # 面向AST编程
# # account stockin
#   参数列表
# 这个是参数列表里的参数
# {:__block__, [],
# [
#   {:import, [line: 67],
#     [
#       {
#         # 名字就是一个三元组
#         {:., [line: 67], [{:__aliases__, [line: 67], [:FishChain, :Test, :Usecase, :Interface]}, :{}]}, [line: 67],
#         [
#           {:__aliases__, [line: 67], [:Account]},
#           {:__aliases__, [line: 67], [:StockIn]}
#         ]
#       }
#     ]
#   },
#   {:actor, [line: 69], [:c1r, {"company1reviewer@justkey.net", "774411"}]}
# ]
# }
# """
