defmodule ShowMacro do
  defmacro show( clause) do
    IO.inspect(clause)
  end
end

defmodule Run do
  import ShowMacro
  show  do
    defcase FishChain.Test.Usecase.StockInTest do
      import FishChain.Actor.CompanyOperator
      import FishChain.Actor.CompanyReviewer

      bizflow "with no thing" do
        
      end
  
      bizflow "stockin - ok" do
          message(:c1o, (apply_stockin))
         
      end
      
      bizflow "stockin - reject" do
          message(:c2o, (apply_stockin))
          message(:c1r, (reject_stockin))
      end
    end
  end
end