defmodule ModuleName do
  defmacro show module_name do
    IO.inspect(module_name)
    
  end
end

defmodule Run do
  import ModuleName
  show A.B.C
  
end