IO.inspect("coding")

<<<<<<< HEAD
defmodule RunMacro do
  defmacro execute(do: clause) do
    # RFID
    
  end
end
=======
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
>>>>>>> 171f840dd61458236273777060a9cf91ff5b8dd9
