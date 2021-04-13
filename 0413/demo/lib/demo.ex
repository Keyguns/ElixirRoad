defmodule Demo do
  @moduledoc """
  Documentation for `Demo`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Demo.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule Func do
  nil
  def add(num) when num > 10 do
    num + 1
  end
  def add(num) do
    num    
  end

end

defmodule Run do
  num = Func.add(12)
  IO.inspect(num)
  a = 8
  a = Func.add(a)
  IO.inspect(a)
end
