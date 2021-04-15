# 测试构建三步走
ExUnit.start()      

defmodule BuildMyTest do
    use ExUnit.Case, async: true
    test "Build-Run" do
      assert :Hello == :Hello
    end
    
    test "Hello" do
      AssertFunction.out
    end
end

defmodule AssertFunction do
  use ExUnit.Case,async: true
  def out do
    assert :ok == :ok       # assert 通过ExUnit 展开 获取定义
  end
end
