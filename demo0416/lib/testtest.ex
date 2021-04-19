ExUnit.start()

defmodule FalseInTest do
  use ExUnit.Case
  test "haha - false" do
    assert false==false
  end
  test "nil nil" do
     nil
  end
end