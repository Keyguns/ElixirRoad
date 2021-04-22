defmodule ShowMacro do

  defmacro showmap do
    %{a: 1,b: 2,c: beoperate} = %{a: 1,b: 2,c: {:%{}, [], [a: 123, b: 123, d: 123]}}
    {asted_map,_} =  Code.eval_quoted(beoperate)
    IO.inspect(asted_map)
    expr=
    quote do
      %{a: 1,b: 2,c: {:%{}, [], [a: 123, b: 123, d: 123]}}
    end
    out=Code.eval_quoted(expr)
    IO.inspect(out)
    :a
    
  end

end 

defmodule Advancemacro do
  import ShowMacro
     
  IO.inspect(showmap())
end

# Code.eval_quoted AST  