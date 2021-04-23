defmodule ShowMacro do
  defmacro show(clause) do
    IO.inspect(clause)
    quote do
      IO.inspect(__MODULE__,label: "Out in macro")
    end

  end
end

defmodule A.B.C do

end

defmodule Run.Hahah.Gan do
  import ShowMacro
  #IO.inspect(__MODULE__)

  IO.inspect(Atom.to_string(show A.B.C),label: "Out After invoke")
end




# A.B.C ==> [:A,:B,:C]
