
defmodule Solvetry do
  import ShowMacro
  
  # show do
  #   import Bizcase.Test.Import
  #   import Bizcase.Test.Import2

  #   bizflow "stockin - ok" do
      
  #   end
  # end

  "test"

  show do
    import Bizcase.Test.Import
    import Bizcase.Test.Import2

    test "stockin - test" do
      assert func(:actor) 
    end
    test "stockin - test" do
      assert func1(:actor) 
      assert func2(:haha)
    end
  end

"test stock in"

  show do
    import Test.Bizflow.StockIn
    bizflow "stockin - ok " do
      message(:c1o, apply_stockin)
      message(:c2o, apply_stockin)
    end
  end

  show do
    defmodule Haha do
      hahaha("开心","快乐")    
    end
  end 
  
end





# {:bizflow, [line: 29],["stockin - ok "  ,[do:                    {:message, [line: 30], [:c1o, {:func_name, [line: 30], nil}]}]]}
# {:test   , [line: 20],["stockin - test", [do:                  {:func_name, [line: 21], [:c1o]}]]}

# {:test   , [line: 20],["stockin - test", [do: {:assert, [line: 21],[{:func, [line: 21], [:actor]}]}]]}

