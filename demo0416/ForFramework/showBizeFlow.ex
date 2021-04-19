defmodule ShowMacro do
  defmacro show( clause) do
    IO.inspect(clause)
    :ok
  end
end


defmodule Run do
  import ShowMacro
  show do
    test "ABCD" do
    end

    test "ABCD" do
      assert haha(:c1r) 
    end

    test "ABCD" do
      assert haha(:c1o)
      assert hahaha(:c1o) 
    end
  end
end

  "show defcase"
# defmodule Run do
#   import ShowMacro
#   show  do
#     defcase FishChain.Test.Usecase.StockInTest do
#       import FishChain.Actor.CompanyOperator
#       import FishChain.Actor.CompanyReviewer

#       bizflow "with no thing" do
        
#       end
  
#       bizflow "stockin - ok" do
#           message(:c1o, (:apply_stockin))
         
#       end
      
#       bizflow "stockin - reject" do
#           message(:c2o, (:apply_stockin))
#           message(:c1r, (:reject_stockin))
#       end
#     end
#   end
# end