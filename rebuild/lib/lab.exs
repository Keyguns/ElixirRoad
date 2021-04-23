defmodule Compose do
  defmacro add(clause) do
    quote do
      unquote(clause)
    end
  end
end




## 必须通过原子构造函数头


defmodule Run do
  import Compose
  %{biz: IO.inspect(:hahaha),func: IO.inspect(:Fight)}


end

Run.haha("haha run")
