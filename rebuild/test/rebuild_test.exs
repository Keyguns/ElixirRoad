import Rebuild

defmodule Usecase.Interface.ApplyStockin do
  def signin("company1operator@justkey.net", "774411") do
    :ok
  end

  def signin(_, _) do
    :error
  end

  def getdone(_, _, _, _) do
    {:ok, [1, 2, 3]}
  end

  def create(_) do
    {:ok, 200}
  end
end

defmodule Usecase.Interface.ApproveStockin do
  def signin(_, _) do
    :ok
  end

  def get_to_do(_, _, _) do
    {:ok, [1, 2, 3, 4]}
  end
end

defmodule Usecase.Interface.RejectStockin do
  def signin(_, _) do
    :ok
  end

  def reject(_) do
    :ok
  end
end

definterface Test.Usecase.Interface.ApplyStockin do
  interface(:ac_signin, signin)
  interface(:ac_getdone, getdone)
  interface(:ac_create, create)
end

definterface Test.Usecase.Interface.ApproveStockin do
  interface(:rc_signin, signin)
  interface(:rc_get_to_do, get_to_do)
end

definterface Test.Usecase.Interface.RejectStockin do
  interface(:ad_signin, signin)
  interface(:ad_reject, reject)
end

defactor Usecase.Test.Actor.CompanyOperator do
  
  import Test.Usecase.Interface.{ApplyStockin, ApproveStockin, RejectStockin}
  actor(:ac1o, {"company1operator@justkey.net", "774411"})
  actor(:rc2o, {"company2operator@justkey.net", "774422"})
  actor(:ad3o, {"company3operator@justkey.net", "774433"})

  defusecase apply_stockin(actor) do
    :ok == user_message(:ac_signin, [actor.login_name, actor.password])
    {:ok, [1, 2, 3]} == user_message(:ac_getdone, [0, 10, 0, 11])
    {:ok, 200} == user_message(:ac_create, [:create])
  end

  defusecase approve_stockin(actor) do
    :ok == user_message(:rc_signin, [actor.login_name, actor.password])
    {:ok, [1, 2, 3, 4]} == user_message(:rc_get_to_do, [1, 2, "12:12"])
  end

  defusecase reject_stockin(actor) do
    :ok == user_message(:ad_signin, [actor.login_name, actor.password])
    :ok == user_message(:ad_reject, [400])
  end
end

# 直接使用 usecase

Usecase.Test.Actor.CompanyOperator.apply_stockin(Usecase.Test.Actor.CompanyOperator.ac1o())
Usecase.Test.Actor.CompanyOperator.approve_stockin(Usecase.Test.Actor.CompanyOperator.rc2o())
Usecase.Test.Actor.CompanyOperator.reject_stockin(Usecase.Test.Actor.CompanyOperator.ad3o())

# case使用usecase

defcase Usecase.Test.Case do
  import Usecase.Test.Actor.CompanyOperator

  bizflow "test - stockin" do
    message(:ac1o, apply_stockin)
    message(:rc2o, approve_stockin)
  end

  bizflow "test - reject - stockin" do
    message(:ac1o, apply_stockin)
    message(:ad3o, reject_stockin)
  end
end

###############    defmodule for test alone  fakes module    ################################

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

defmodule Test.SignIn do
  @moduledoc "use for test"
  def sign_in(_, _) do
    :ok
  end
end

defmodule Test.Getlist do
  @moduledoc "use for test"
  def get_list(_, _, _, _) do
    {:ok, [:ok, :ok]}
  end
end

defmodule Test.Approve do
  @moduledoc "use for test"
  def approve(_, _) do
    :ok
  end
end

defmodule Bizcase.Test.Import1 do
  @moduledoc "use for bizetest "
end

defmodule Bizcase.Test.Import2 do
  @moduledoc "use for bizetest "
end

defmodule Bizflow.Test.StockIn do
  @moduledoc "use for bizflow test"
  use ExUnit.Case, async: true
  def c1o, do: :ok
  def c2o, do: :ok
  def c3o, do: :ok

  def apply_stockin(_actor) do
    assert :ok == :ok
  end
end

################   Module use for test  ###################################################

defmodule Yzd.Dsl.UsecaseTest do
  use ExUnit.Case, async: true

  #  test "defactor - ok" do   #先判断能否运行
  #    expected = """
  #    defmodule A do
  #    end
  #    """
  #
  #    expr = quote do: defactor(A, do: :ok)
  #    res = Macro.expand_once(expr, __ENV__)
  #    assert expected == Macro.to_string(res)
  #  end
  #

  test "actor - definitions - one - item" do
    defactor Single do
      actor(:a, {"aloginname", "apassword"})
    end

    assert Single.a() == %{login_name: "aloginname", password: "apassword"}

    assert "aloginname" == Single.a().login_name
    assert "apassword" == Single.a().password
  end

  test "actor - definitions-two-items" do
    defactor A do
      actor(:a, {"aloginname", "apassword"})
      actor(:b, {"bloginname", "bpassword"})
    end

    assert A.a() == %{login_name: "aloginname", password: "apassword"}
    assert A.b() == %{login_name: "bloginname", password: "bpassword"}

    assert "aloginname" == A.a().login_name
    assert "apassword" == A.a().password
    assert "bloginname" == A.b().login_name
    assert "bpassword" == A.b().password
  end

  # left:  %{biz: [:A, :B], func: :getlist}
  test "definterface - run -one item" do
    definterface Test.Single.A.B do
      interface(:userA1, getlist)
    end

    assert Test.Single.A.B.userA1() == %{biz: Single.A.B, func: :getlist}
  end

  # defmodule Test.Single.A.B do
  #   def userA1 ,do: %{biz: A.B,func: getlist}
  # end

  test "definterface - run - two-items" do
    definterface Test.A.B do
      interface(:userA1, signin)
      interface(:userA2, getone)
    end

    assert Test.A.B.userA1() == %{biz: A.B, func: :signin}
    assert Test.A.B.userA2() == %{biz: A.B, func: :getone}
  end

  # import 比较难以验证,需要时打开注释
  test "defactor - import - run " do
    defactor Actor.Import1 do
      # import FishChain.Test.Usecase.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
    end

    defactor Actor.Import2 do
      # import FishChain.Test.Usecase.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})
    end
  end

  test "defactor - defusecase - function(null)" do
    defactor Actor.Function0 do
      # import FishChain.Test.Usecase.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})

      defusecase stock_in(_actor) do
      end
    end

    assert Actor.Function0.stock_in(:actor) == nil
  end

  test "defactor - defusecase - run-muti_defusecase" do
    defactor Actor.DefusecaseRun do
      # import FishChain.Test.Usecase.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})

      defusecase stock_in(_actor) do
      end

      defusecase stock_out(_actor) do
      end
    end

    assert Actor.DefusecaseRun.stock_in(:actor) == nil
    assert Actor.DefusecaseRun.stock_out(:actor) == nil
  end

  test "defactor - defusecase - function - run - one - two -message" do
    defactor Actor.Defusecase1_1 do
      import Test.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})

      defusecase approve_stockin(actor) do
        :ok == user_message(:ac_signin, [actor.login_name, actor.password])
      end
    end

    assert Actor.Defusecase1_1.approve_stockin(Actor.Defusecase1_1.c1r()) == true
  end

  test "defactor - defusecase -function - run - two -messages" do
    defactor Actor.Defusecase1_3 do
      import Test.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})

      defusecase approve_stockin(actor) do
        :ok == user_message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == user_message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == user_message(:si_approve, [:data, :approved])
      end
    end

    assert Actor.Defusecase1_3.approve_stockin(Actor.Defusecase1_3.c1r()) == true
  end

  test "defactor - defusecase -function - run - two -defusecase" do
    defactor Actor.Defusecase2_3 do
      import Test.Interface.{Account, StockIn}
      actor(:c1r, {"company1reviewer@justkey.net", "774411"})
      actor(:c2r, {"company1reviewer@justkey.net", "774411"})

      defusecase approve_stockin(actor) do
        :ok == user_message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == user_message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == user_message(:si_approve, [:data, :approved])
      end

      defusecase approve_stockin2(actor) do
        :ok == user_message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == user_message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == user_message(:si_approve, [:data, :approved])
      end
    end

    # 调用生成函数才能执行生成assert
    Actor.Defusecase2_3.approve_stockin(Actor.Defusecase2_3.c1r())
  end

  test "defcase - run - no - import" do
    defcase Bizflow.Import0 do
    end
  end

  test "defcase - run - import - once" do
    defcase Bizflow.Import1 do
      import Bizcase.Test.Import1
    end
  end

  test "defcase - run - import - twice" do
    defcase Bizflow.Import2 do
      import Bizcase.Test.Import1
      import Bizcase.Test.Import2
    end
  end

  test "defmase - run - bizflow -one case- no body" do
    defcase Bizeflow.Flow1_0 do
      bizflow "stockin - ok " do
      end
    end
  end

  test "defmase - run - bizflow - two case- no body " do
    # import Test.Interface.StockIn
    defcase Bizeflow.Flow2_0 do
      bizflow "stockin - ok - 1 " do
      end

      bizflow "stockin - ok - 2 " do
      end
    end
  end

  # usecase 位于import module中 直接通过函数名调用
  test "defmase - run - bizflow -one case with one message" do
    defcase Bizeflow.Flow1_1 do
      import Bizflow.Test.StockIn

      bizflow "stockin - ok " do
        message(:c1o, apply_stockin)
      end
    end
  end

  test "defmase - run - bizflow -two case with one message" do
    defcase Bizeflow.Flow2_1 do
      import Bizflow.Test.StockIn

      bizflow "stockin - ok1 " do
        message(:c1o, apply_stockin)
      end

      bizflow "stockin - ok2 " do
        message(:c1o, apply_stockin)
      end
    end
  end

  test "defmase - run - bizflow -one case with multi message" do
    defcase Bizeflow.Flow1_3 do
      import Bizflow.Test.StockIn

      bizflow "stockin - ok " do
        message(:c1o, apply_stockin)
        message(:c2o, apply_stockin)
        message(:c3o, apply_stockin)
      end
    end
  end

  test "defcase - run - bizflow -multi case with multi message" do
    defcase Bizeflow.Flow2_3 do
      import Bizflow.Test.StockIn

      bizflow "stockin - ok-1 " do
        message(:c1o, apply_stockin)
        message(:c2o, apply_stockin)
        message(:c3o, apply_stockin)
      end

      bizflow "stockin - ok-2 " do
        message(:c1o, apply_stockin)
        message(:c2o, apply_stockin)
        message(:c3o, apply_stockin)
      end
    end
  end
end





# defmodule Test.Interface.Account do
#   @moduledoc "use for test"
# end

# defmodule Test.SignIn do
#   @moduledoc "use for test"
#   def sign_in(_, _) do
#     :ok
#   end
# end

# defmodule Test.Getlist do
#   @moduledoc "use for test"
#   def get_list(_, _, _, _) do
#     {:ok, [:ok, :ok]}
#   end
# end

# defmodule Test.Approve do
#   @moduledoc "use for test"
#   def approve(_, _) do
#     :ok
#   end
# end
# defmodule Test.Interface.StockIn do
#   @moduledoc "use for test"
#   @ac_signin %{biz: Test.SignIn, func: :sign_in}
#   @si_getlist %{biz: Test.Getlist, func: :get_list}
#   @si_approve %{biz: Test.Approve, func: :approve}
#   def ac_signin, do: @ac_signin
#   def si_getlist, do: @si_getlist
#   def si_approve, do: @si_approve
# end

# defmodule Test.Interface.Account do
#   @moduledoc "use for test"
# end

# # 嵌套定义会导致__MODULE__ 增加前缀



# defmodule RebuildTest do
#   use ExUnit.Case

#   defactor Usecase.Test.Actor.CompanyOperator do
#     import Test.Interface.{StockIn,Account}
#     import Eval.Module
    
#     actor(:ac1o, {"company1operator@justkey.net", "774411"})
#     actor(:rc2o, {"company2operator@justkey.net", "774422"})
#     actor(:ad3o, {"company3operator@justkey.net", "774433"})
  
#     defusecase apply_stockin(actor) do
#       # import Kernel,except: [==: 2]
#       :ok == user_message(:ac_signin, [actor.login_name, actor.password])
#       {:ok, [:ok, :ok]} == user_message(:si_getlist, [0, 10, 0, "12:12"])
#       :ok == user_message(:si_approve, [:data, :approved])
#     end
  
#     defusecase approve_stockin(_actor) do
#     #   :ok == message(:rc_signin, [actor.login_name, actor.password])
#     #   {:ok, [1, 2, 3, 4]} == message(:rc_get_to_do, [1, 2, "12:12"])
#     end
  
#     defusecase reject_stockin(_actor) do
#     #  :ok == message(:ad_signin, [actor.login_name, actor.password])
#     #  :ok == message(:ad_reject, [400])
#     end
#   end

#   test "defactor - actor" do
#     assert Usecase.Test.Actor.CompanyOperator.ac1o == %{login_name: "company1operator@justkey.net",password:  "774411"}
#   end

#   test "defactor - defusecase - run" do 
#     Usecase.Test.Actor.CompanyOperator.apply_stockin(Usecase.Test.Actor.CompanyOperator.ac1o)
#     Usecase.Test.Actor.CompanyOperator.approve_stockin(Usecase.Test.Actor.CompanyOperator.ac1o)
#   end

#   definterface Test.A.B.C do
#     interface(:ac_getlist,getlist)
#   end

#   test "definterface" do
#     assert Test.A.B.C.ac_getlist().biz == A.B.C
#   end
# end

