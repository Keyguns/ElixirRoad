defmodule RunTest do
  use ExUnit.Case
  doctest Demo
  import Run

  test "greets the world" do
    assert Demo.hello() == :world
  end

  test "Hello - Test" do
    assert Run.hello() == :HelloTest
  end
end
