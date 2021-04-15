[
    do: {:__block__, [],
        [
        :ok =  message(actor,:ac_signin,[:actor.login_name,:actor.password])
        {:=, [line: 113],
        [
            :ok,

            # message(actor,:ac_signin,[:actor.login_name,:actor.password])

            {:message, [line: 113],
            [
                {:actor, [line: 113], nil},
                :ac_signin,
                [
                {{:., [line: 113], [{:actor, [line: 113], nil}, :loginname]},
                [no_parens: true, line: 113], []},
                {{:., [line: 113], [{:actor, [line: 113], nil}, :password]},
                [no_parens: true, line: 113], []}
                ]
            ]
            }
        ]
        },

        {:=, [line: 114],
        [
            {:ok, {:list, [line: 114], nil}},
            {:message, [line: 114],
            [
                {:actor, [line: 114], nil},
                :si_getlist,
                [
                0,
                10,
                0,
                {{:., [line: 114], [{:time, [line: 114], nil}, :now]},
                [line: 114], []}
                ]
            ]}
        ]},
        {:=, [line: 115],
        [
            {:ok, {:data, [line: 115], nil}},
            {:message, [line: 115],
            [
                {:actor, [line: 115], nil},
                :si_getone,
                [{:..., [line: 115], nil}]
            ]}
        ]},
        {:=, [line: 116],
        [
            :ok,
            {:message, [line: 116],
            [
                {:actor, [line: 116], nil},
                :si_approve,
                [
                {{:., [line: 116], [{:data, [line: 116], nil}, :id]},
                [no_parens: true, line: 116], []},
                {:@, [line: 116], [{:approved, [line: 116], nil}]}
                ]
            ]}
        ]}
    ]}
]

