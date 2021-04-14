# 测试构建三步走
ExUnit.start()      

defmodule BuildMyTest do
    use ExUnit.Case, async: true
    test "Build-Run" do
      assert :Hello == :Hello
    end
end