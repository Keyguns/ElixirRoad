defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test "greets the world" do
    assert Demo.hello() == :world
  end

  test "list-pipe" do
    [head|rear] = [1,2,3,4,5]
    assert rear == [2,3,4,5]
    [a,b] = [head,rear]
    assert [a,b] == [1,[2,3,4,5]]
    turn_back = [head|rear]
    assert turn_back ==[1,2,3,4,5]
  end

  test "unmatch-function" do

  end

  test "Run-apply" do
    # 参数以参数列表形式存放
    apply(ModuleName,:func_name,[[1,2,3,4,5]])
  end

  test "list-keyword" do
    list = [{:a,:b,:sduhfiahfuhai},[:cde,:a,:d],{[:c]},:d]
    assert List.Keyfind(list,:a,0) == {:a,:b,:sduhfiahfuhai}
    assert List.Keyfind(list,:c,0) == nil
    assert List.Keyfind(list,:cde,0) == [:cde,:a,:d]
  end



end
