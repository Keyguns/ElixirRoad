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

  def null do
  end
end

# test unmatch function
defmodule Run do

  num = Func.add(12)
  IO.inspect(num)
  a = 8
  a = Func.add(a)
  IO.inspect(a)

  IO.inspect(Func.null)
end



defmodule ModuleName do
  def func_name(input) do
    Enum.map(input,fn input_item -> IO.inspect(input_item) end )
  end
end

defmodule AwithB do
  def a do
    :ok
  end
  def b do
    IO.inspect(a())
  end
end

AwithB.b()

