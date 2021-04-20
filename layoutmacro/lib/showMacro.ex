defmodule ShowMacro do

  defmacro show(clause) do
    IO.inspect(clause)
    :a
  end
end

# 
