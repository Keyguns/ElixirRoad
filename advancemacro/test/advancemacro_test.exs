defmodule AdvancemacroTest do
  use ExUnit.Case
  doctest Advancemacro

  test "greets the world" do
    assert Advancemacro.hello() == :world
  end
end
