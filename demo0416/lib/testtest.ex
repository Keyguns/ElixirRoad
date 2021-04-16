ExUnit.start()

defmodule FalseInTest do
  use ExUnit.Case
  test "haha - false" do
    assert false
  end
end