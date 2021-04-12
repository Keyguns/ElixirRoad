{:__block__, [],
 [
    #import FishChain.Test.Usecase.Interface.{Account, StockIn}
    {:import, [context: Elixir],
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
          #with 参数
          [
            {:__aliases__, [alias: false], [:Account]},
            {:__aliases__, [alias: false], [:StockIn]}
          ]
        }
      ]
    },


   {:actor, [], [:c1o, {"company1operator@justkey.net", "774411"}]},
   {:actor, [], [:c2o, {"company2operator@justkey.net", "774411"}]},

   # defusecase need to be deal
   {:defusecase, [],
    [
      {:apply_stockin, [], [{:actor, [], Elixir}]},
      [
        do: {:__block__, [],
         [
           {:=, [],
            [
              :ok,
              {:message, [],
               [
                 {:actor, [], Elixir},
                 :ac_signin,
                 [
                   {{:., [], [{:actor, [], Elixir}, :loginname]},
                    [no_parens: true], []},
                   {{:., [], [{:actor, [], Elixir}, :password]},
                    [no_parens: true], []}
                 ]
               ]}
            ]},
           {:=, [],
            [
              {:ok, {:list, [], Elixir}},
              {:message, [],
               [
                 {:actor, [], Elixir},
                 :si_getlist,
                 [0, 10, 0, {{:., [], [{:time, [], Elixir}, :now]}, [], []}]
               ]}
            ]},
           {:=, [],
            [
              {:ok, {:data, [], Elixir}},
              {:message, [],
               [{:actor, [], Elixir}, :si_create, [{:..., [], Elixir}]]}
            ]}
         ]}
      ]
    ]
    }



 ]
}
