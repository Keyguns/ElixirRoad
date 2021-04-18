# use function to expand macro

# 强调代码的鲁棒性

# 之前一直处理的block
# Todo 新的 def

defmodule Demo0415 do



end

defmodule Demo14 do

  defmacro defmyfunc(do: clause) do
    quote do
      defmodule hellodomain do


      end
    end
  end
end

# ==> definterface 算是一个
#
#
#
