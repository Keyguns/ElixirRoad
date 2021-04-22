IO.inspect("coding")

defmodule Hahaha do
  defmacro mod_name() do
    quote do
    __MODULE__
    end
  end 
  IO.inspect(__MODULE__)
end

defmodule RunLabS do
  import Hahaha
  IO.inspect(mod_name(),label: "Out in RunLabs")
#   宏在运行前编译
  IO.inspect(__ENV__)
end 