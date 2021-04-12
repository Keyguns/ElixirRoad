
defmodule DemoTest do
  use ExUnit.Case
  doctest Demo

  test "greets the world" do
    assert Demo.hello() == :world
  end

  test "get import" do
    {_,_,[{impo,_,module_name}|rest]}=Show.show()
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
  
  test "pop" do
    pop()
    IO.inspect("")
    #IO.inspect("")
  end
end
