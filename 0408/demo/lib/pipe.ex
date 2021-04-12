# pipe just pass the value not influence the process
defmodule Pipe do
  def hope_out_add6(num) do
    add1(num)
    |>add1()
    |>add1()
    |>add1()
    |>add1()
    |>add1()

  end
  def add1(num) do
    num+1
  end
end
defmodule Run do
  import Pipe
  IO.puts(hope_out_add6(12))
end
