defmodule Invoke do
  def invoke_fun(num) do
    IO.inspect(num)
  end
  defmacro inv do
    {:invoke_fun,[],[1]}
  end
end

defmodule Run do
  import Invoke
#   Code.eval_quoted({:invoke_fun,[],[1]})
  inv
  invoke_fun(1)
end