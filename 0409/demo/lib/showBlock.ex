# get(keywords, key, default \\ nil)
# get_lazy(keywords, key, fun)
#语句块以列表形式存在
defmodule Show do
  def show do
    _astActor = quote do
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
  # IO.inspect (astActor)
  end
end

defmodule ShowActorOnly do
  def show_actor_only()do
    quote do

        actor(:c1o, {"company1operator@justkey.net", "774411"})
        actor(:c2o, {"company2operator@justkey.net", "774411"})

    end
  end
end



IO.inspect(ShowActorOnly.show_actor_only())

# Keyword.get(clause,:do,nil)
defmodule My do
  defmacro testMacro(condition,clause)do
    IO.inspect(condition)
    IO.inspect(clause)
  end
end



defmodule Run do
  require My
  #语句块形成关键字列表
  My.testMacro 1==2 do
    IO.puts "1==2"
  else
    IO.puts "1!=2"
  end
end
