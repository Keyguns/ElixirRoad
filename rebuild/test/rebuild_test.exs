import Rebuild

defmodule Test.Interface.StockIn do
  @moduledoc "use for test"
  @ac_signin %{biz: Test.SignIn, func: :sign_in}
  @si_getlist %{biz: Test.Getlist, func: :get_list}
  @si_approve %{biz: Test.Approve, func: :approve}
  def ac_signin, do: @ac_signin
  def si_getlist, do: @si_getlist
  def si_approve, do: @si_approve
end

defmodule Test.Interface.Account do
  @moduledoc "use for test"
end

defmodule RebuildTest do
  use ExUnit.Case
  # expr = 
  # quote do

    defactor Usecase.Test.Actor.CompanyOperator do
      import Test.Interface.{StockIn,Account}
      actor(:ac1o, {"company1operator@justkey.net", "774411"})
      actor(:rc2o, {"company2operator@justkey.net", "774422"})
      actor(:ad3o, {"company3operator@justkey.net", "774433"})
    
      defusecase apply_stockin(actor) do
        # :ok = message(:ac_signin, [actor.login_name, actor.password])
        # {:ok, [1, 2, 3]} = message(:ac_getdone, [0, 10, 0, 11])
        # {:ok, 200} = message(:ac_create, [:create])
      end
    
      defusecase approve_stockin(actor) do
      #   :ok = message(:rc_signin, [actor.login_name, actor.password])
      #   {:ok, [1, 2, 3, 4]} = message(:rc_get_to_do, [1, 2, "12:12"])
      end
    
      defusecase reject_stockin(actor) do
      #   :ok = message(:ad_signin, [actor.login_name, actor.password])
      #   :ok = message(:ad_reject, [400])
      end
    end

  # end

  # Macro.expand_once(expr,__ENV__)
  # |> Macro.expand_once(__ENV__)
  # |> Macro.to_string()
  # |> IO.puts()
  
  test "defacot - actor" do
    assert Usecase.Test.Actor.CompanyOperator.ac1o == %{login_name: "company1operator@justkey.net",password:  "774411"}
  end

  test "defacot - defusecase - run" do 
    Usecase.Test.Actor.CompanyOperator.apply_stockin(:LaDeng)
    Usecase.Test.Actor.CompanyOperator.approve_stockin(:LaDeng)
  end
  
end

