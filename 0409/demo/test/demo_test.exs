
defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test "greets the world" do
    assert Demo.hello() == :world
  end

  test "get import" do
    {_,_,[{impo,_,module_name}|_rest]}=Show.show()
    my_import={impo,[context: Elixir],module_name}
                        ## import FishChain.Test.Usecase.Interface.{Account, StockIn}
    assert my_import=={:import, [context: Elixir],
                        #FishChain.Test.Usecase.Interface.{Account, StockIn}
                        [
                          {
                            #name
                            {:., [],
                            [
                              {:__aliases__, [alias: false],
                              [:FishChain, :Test, :Usecase, :Interface]},
                              :{}
                            ]},
                            #meta data
                            [],
                            #args
                            [
                              {:__aliases__, [alias: false], [:Account]},
                              {:__aliases__, [alias: false], [:StockIn]}
                            ]
                          }
                        ]
                      }
     IO.puts(Macro.to_string(my_import))
  end

  test "get keyword list from list" do
  end


# 变量不变意味着行参 实参问题
  test "variable value" do
    number = 12
    Variable.add(number)
    assert number == 12
  end

  test "variable differ" do
    
  end
end


defmodule Variable do
  def add(num)do
    num = num + 100
  end
end
