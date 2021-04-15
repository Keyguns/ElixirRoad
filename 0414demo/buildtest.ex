# 测试构建三步走
# 单个文件随意打开到一个文件中
#通过测试Output assert result : true
#为通过断言可能导致终止运行
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
    assert :ok == :ok      # assert 通过ExUnit 展开 获取定义
  end
end

IO.inspect(AssertFunction.out,label: "Output assert result")