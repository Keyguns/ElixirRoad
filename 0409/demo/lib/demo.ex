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
<<<<<<< HEAD

=======
  def add do
    IO.inspect hello()
    IO.inspect hello()
  end
>>>>>>> be66da46a43140dd79f1eee4e7da88b0e413b35e
end

Demo.hello()
