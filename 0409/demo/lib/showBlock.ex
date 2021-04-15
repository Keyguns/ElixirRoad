# get(keywords, key, default \\ nil)
# get_lazy(keywords, key, fun)
#语句块以列表形式存在
defmodule Show do
  def show do
    quote do
      import FishChain.Test.Usecase.Interface.{Account, StockIn}

      actor(:c1o, {"company1operator@justkey.net", "774411"})
      actor(:c2o, {"company2operator@justkey.net", "774411"})

      defusecase apply_stockin(actor) do
        # resp      = message(<act>, <interface>, [params                         ])
        :ok         = message(actor, :ac_signin,  [actor.loginname, actor.password])
        {:ok, list} = message(actor, :si_getlist, [0, 10, 0, time.now()           ])
        {:ok, data} = message(actor, :si_create,  [...                            ])
      end
    end
  end
  def haha() do
    IO.inspect("HaHa")
  end
  IO.inspect("haha")
end
IO.inspect(Show.show())

defmodule ShowActorOnly do
  def show_actor_only()do
    quote do

        actor(:c1o, {"company1operator@justkey.net", "774411"})
        actor(:c2o, {"company2operator@justkey.net", "774411"})

    end
  end
end



IO.inspect(ShowActorOnly.show_actor_only())

<<<<<<< HEAD
# defmodule My do
#   defmacro testMacro(condition,clause)do
#     IO.inspect(condition)
#     IO.inspect(clause)
#   end
# end
=======
# Keyword.get(clause,:do,nil)
defmodule A.My do
  defmacro testMacro(condition,clause)do
    IO.inspect(condition)
    IO.inspect(clause)
  end
end
>>>>>>> be66da46a43140dd79f1eee4e7da88b0e413b35e

# defmodule Run do
#   require My
#   #语句块形成关键字列表
#   My.testMacro 1==2 do
#     IO.puts "1==2"
#   else
#     IO.puts "1!=2"
#   end
# end
<<<<<<< HEAD
=======


defmodule TestMacro  do
  defmacro test_macro(module_name,do: clause) do
    IO.inspect(clause)
  end
end


defmodule Run do
  require TestMacro
  TestMacro.test_macro A.B.C do
    import A.My
    IO.inspect("name")
  end
end
>>>>>>> be66da46a43140dd79f1eee4e7da88b0e413b35e
