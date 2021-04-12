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

defmodule UseImport do
  def out()do
    IO.puts("Hello Import")
  end
end
