alias Yzd.Dsl.Usecase.Parser, as: P
alias Yzd.Dsl.Usecase.Generator, as: G

defmodule Yzd.Dsl.Usecase do
  defmacro defcase(module_name,do: case_block) do
    {def_import,clause} = P.parse_import(case_block)
    biz_case = parse_biz_case(clause)
    quote do
      defmodule unquote(bize_name)do
        @moduledoc false
        use ExUnit.Case, async: true

        unquote(def_import)
        unquote(biz_case)
      end

    end  
  end

end


defmodule Yzd.Dsl.Usecase.Parser do
  def parse_bizflow(bize_clause)do
    
  end 
end


# defcase Usecase.Test.Case do
#   import Usecase.Test.Actor.CompanyOperator

#   bizflow "test - stockin" do
#     message(:ac1o, apply_stockin)
#     message(:rc2o, approve_stockin)
#   end

#   bizflow "test - reject - stockin" do
#     message(:ac1o, apply_stockin)
#     message(:ad3o, reject_stockin)
#   end
# end


