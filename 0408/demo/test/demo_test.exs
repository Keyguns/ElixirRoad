defmodule RunTest do
  use ExUnit.Case
  doctest Demo
  import Run

  test "greets the world" do
    assert Demo.hello() == :world
  end

  test "assert" do
    assert {:Hello,:world}|>elem(1) == :world
  end
  
end
