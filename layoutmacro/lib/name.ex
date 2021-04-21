# 名子问题通过参数个数区别
defmodule Defin do
  number = 10
  def number(number) do
    IO.inspect(number)
  end 

end 

defmodule Run do
    Defin.number(10)
end 