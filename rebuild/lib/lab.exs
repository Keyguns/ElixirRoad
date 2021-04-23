defmodule Compose do
  defmacro add(clause) do
    quote do
      unquote(clause)
    end
  end


## 必须通过原子构造函数头
  defmacro build_func(func_name) when is_atom(func_name) do
    quote do
      def unquote(func_name)(input),do: IO.inspect(input)
    end
  end

  defmacro build_func(func_name)  do
    quote do
      def unquote(func_name)(input),do: IO.inspect(input)
    end
  end
end



defmodule Run do
  import Compose

  build_func :haha

end

Run.haha("haha run")
