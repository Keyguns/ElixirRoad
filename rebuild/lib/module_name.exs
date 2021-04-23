defmodule Test.ModuleName.A.B do
impoort  # MODUlE 是__ENV__的 ShortCut

  IO.inspect(__MODULE__)
  
  module_name = __MODULE__
  module_name = gen_module(module_name)
  IO.inspect(module_name)
end

defmodule Generater do
  def gen_module(module_name) do
    
  end
end

