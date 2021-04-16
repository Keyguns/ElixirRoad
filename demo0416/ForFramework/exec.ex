defmodule Test do 
  def message(actor, usecase_invoke) do
      quote do 
      assert unquote(usecase_invoke)(unquote(actor))
      end
  end
end

IO.inspect(Macro.to_string(Macro.expand_once(Test.message(:c1r,:approve_stock_in),__ENV__)))

