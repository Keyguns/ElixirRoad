# one sentence in block
# block 对于语句没有影响
defmodule BlockMacro do
  defmacro show(clause)do
    IO.inspect(clause)
    
  end
  defmacro haha do
    {:__block__,[],[{{:., [line: 15], [{:__aliases__, [line: 15], [:IO]}, :inspect]},
    [line: 15], ["HaHa"]},]}
  end
end

defmodule Run do
    import BlockMacro
    show do
        IO.inspect("HaHa")
        IO.inspect("wenkday")
    end

    haha
end

