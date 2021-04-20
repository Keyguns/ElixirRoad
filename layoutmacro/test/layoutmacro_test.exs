defmodule LayoutmacroTest do
  use ExUnit.Case
  doctest Layoutmacro

  test "greets the world" do
    assert Layoutmacro.hello() == :world
  end
end
