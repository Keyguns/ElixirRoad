defmodule ShowMacro do
  defmacro show(clause) do
    IO.inspect(clause,label: "module_name AST")
    quote do
      IO.inspect(__MODULE__,label: "Out in macro")
    end
  end
end

defmodule A.B.C do

end

defmodule Run.Hahah.Gan do
  import ShowMacro

  IO.inspect(Atom.to_string(show A.B.C),label: "Out After invoke")
end




# A.B.C ==> {:__aliases__, [line: 19], [:A, :B, :C]}
# 
# "Elixir.Run.Hahah.Gan"