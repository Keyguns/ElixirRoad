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
  def add do
    IO.inspect hello()
    IO.inspect hello()
  end
end
