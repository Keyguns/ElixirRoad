defmodule Haha do
    
  defmacro show_import(_module_name,do: import_block)do
    IO.inspect(import_block)
  end
end


defmodule A do
end

defmodule B do
end

defmodule Outside do
  defmodule Run do 
  import Haha
  show_import last_year do
      import A
      import B
  end
  end
end


IO.puts("AST with meta")
IO.puts(Macro.to_string(Macro.expand_once({:import, [context: Yzd.Dsl.UsecaseTest],[{:__aliases__, [alias: false], [:Test, :Bizcase, :ImportA]}]},__ENV__)))
IO.puts("AST without meta")
IO.puts(Macro.to_string(Macro.expand_once({:import, [],[{:__aliases__, [alias: false], [:Test, :Bizcase, :ImportA]}]},__ENV__)))
