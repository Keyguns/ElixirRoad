defmodule ForUsing do
  defmacro __using__(_opts) do
    quote do
    @name "BenLaDeng"
    end
  end
end

defmodule ForImport do
  @name "KaZhaFei"
end

defmodule RunUsing do
  use ForUsing
  IO.puts(@name)
end

#无法从外部访问属性
defmodule RunImport do
  import ForImport
  IO.puts(@name)
end
