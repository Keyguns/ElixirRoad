defmodule Sample do
  defmacrop two, do: 2
  def four, do: two + two
  
end