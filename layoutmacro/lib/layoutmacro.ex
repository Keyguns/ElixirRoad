defmodule Layoutmacro do
  defmacro layout(module_name,do: clause) do

    quote do
      defmodule unquote(module_name) do

      end
    end
  end

  defmacro layout do
    :ok
  end

  def haha(),do: :ok
end


