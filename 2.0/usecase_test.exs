import Yzd.Dsl.Usecase

### module prepared for expand code using

defmodule Usecase.Interface.ApplyStockin do
  def signin("ac1o@justkey.net", "774411"), do: :ok
  def signin(_, _), do: :login_error
  def getdone(_, _, _, _), do: {:ok, [1, 2, 3]}
  def create(_), do: {:ok, 200}
end

defmodule Usecase.Interface.ApproveStockin do
  def signin("rc2o@justkey.net", "774422"), do: :ok
  def signin(_, _), do: :ApproveStocin_SignInError
  def get_to_do(_, _, _), do: {:ok, [1, 2, 3, 4]}
end

defmodule Usecase.Interface.RejectStockin do
  def signin("ad3o@justkey.net", "774433"), do: :ok
  def signin(_, _), do: :RejectStockin_SignInError
  def reject(_), do: :ok
end

### use macro to expand word for testing

definterface Test.Usecase.Interface.ApplyStockin, Usecase.Interface.ApplyStockin do
  interface(:ac_signin, signin)
  interface(:ac_getdone, getdone)
  interface(:ac_create, create)
end

definterface Test.Usecase.Interface.ApproveStockin, Usecase.Interface.ApproveStockin do
  interface(:rc_signin, signin)
  interface(:rc_get_to_do, get_to_do)
end

definterface Test.Usecase.Interface.RejectStockin, Usecase.Interface.RejectStockin do
  interface(:ad_signin, signin)
  interface(:ad_reject, reject)
end

defactor Usecase.Test.Actor.CompanyOperator do
  import Test.Usecase.Interface.{ApplyStockin, ApproveStockin, RejectStockin}
  actor(:ac1o, {"ac1o@justkey.net", "774411"})
  actor(:rc2o, {"rc2o@justkey.net", "774422"})
  actor(:ad3o, {"ad3o@justkey.net", "774433"})

  defusecase apply_stockin(actor) do
    :ok == message(:ac_signin, [actor.login_name, actor.password])
    {:ok, [1, 2, 3]} == message(:ac_getdone, [0, 10, 0, 11])
    {:ok, 200} == message(:ac_create, [:create])
  end

  defusecase approve_stockin(actor) do
    :ok == message(:rc_signin, [actor.login_name, actor.password])
    {:ok, [1, 2, 3, 4]} == message(:rc_get_to_do, [1, 2, "12:12"])
  end

  defusecase reject_stockin(actor) do
    :ok == message(:ad_signin, [actor.login_name, actor.password])
    :ok == message(:ad_reject, [400])
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
    definterface Test.Single.A.B, Single.A.B do
      interface(:userA1, getlist)
    end

    assert Test.Single.A.B.userA1() == %{biz: Single.A.B, func: :getlist}
  end

  test "definterface - run - two-items" do
    definterface Test.A.B, A.B do
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
        :ok == message(:ac_signin, [actor.login_name, actor.password])
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
        :ok == message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == message(:si_approve, [:data, :approved])
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
        :ok == message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == message(:si_approve, [:data, :approved])
      end

      defusecase approve_stockin2(actor) do
        :ok == message(:ac_signin, [actor.login_name, actor.password])
        {:ok, [:ok, :ok]} == message(:si_getlist, [0, 10, 0, "12:12"])
        :ok == message(:si_approve, [:data, :approved])
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

#### test with real usecase diagram but without

definterface Yzd.Usecase.Test.FishChain.Biz.AccountBiz,
             FishChain.Biz.AccountBiz do
  # 如果需要多个Module,根据所需Module分类定义definterface
  interface(:rev_signin, signin)
end

definterface Yzd.Usecase.Test.FishChain.Domain.Account,
             FishChain.Domain.Account do
  interface(:rev_create4test, create4test)
end

defactor Yzd.Dsl.Usecase.Test.SingIn do
  import Yzd.Usecase.Test.FishChain.{Biz.AccountBiz, Domain.Account}

  actor(:tester1, {"18820242012", "774411"})

  defusecase signin_ok(actor) do
    message(:rev_create4test, [actor.login_name, actor.password])
    :result_data_cookie == message(:rev_signin, [actor.login_name, actor.password]) |> elem(0)
  end
end

defcase Yzd.Dsl.Usecase.Test.Defactor.SignIn do
  import Yzd.Dsl.Usecase.Test.SingIn

  bizflow "sign-in-ok" do
    message(:tester1, signin_ok)
  end
end
