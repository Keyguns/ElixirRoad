#[:A,:B,:C] ==> A.B.C
#[A,B,C] ==> Elixir.A.Elixir.B.Eixir.C != A.B.C
#            :"Elixir.A.B.C"           == A.B.C
### is different between [A,B,C] and [:A,:B,:C]

# solve the problem change name
defmodule Name do
  def change(in_name)do
    # Enum.map(in_name,fn name -> IO.inspect(name)|>Atom.to_string()|>IO.inspect() end)
      in_name=Enum.join(in_name,".")
      in_name="Elixir."<>in_name
      String.to_atom(in_name)
  end
end

defmodule RunMN do
  IO.inspect(Name.change([:A,:B,:C])==A.B.C)

end


# to_string(list)

# Converts a list of integers representing code points, lists or strings into a string.
