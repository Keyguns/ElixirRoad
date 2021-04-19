# test 函数调用问题
ExUnit.start()
defmodule Bizflow.StockIn do
  @moduledoc "use for bizflow test"
  use ExUnit.Case, async: true
  def gan do
    assert :ok ==:ok
  end
end

# 

defmodule Turn do
  use ExUnit.Case, async: true
  test "hahah" do
    Bizflow.StockIn.gan
  end 
end




# defmodule Test.Bizeflow.Flow1_1 do
#     import Test.Bizflow.StockIn
    

#     apply_stockin(:c1o)
# end

# 语法较劲