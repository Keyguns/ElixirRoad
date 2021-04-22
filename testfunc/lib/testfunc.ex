defmodule Testfunc do
  
  def multi_return() do
    [
      IO.puts("A"),
      IO.puts("A"),
      IO.puts("A"),
      IO.puts("A"),
      IO.puts("A"),
      IO.puts("A")
    ]
  end 

end

rec = Testfunc.multi_return
IO.inspect(rec)


