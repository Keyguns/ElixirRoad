# Elixir 中命名太繁琐了
ExUnit.start()
defmodule Test.Bizcase.Import do 
    def haha,do: :ok
end

# import 模块名如果与所属模块名有重叠会导致import的模块名根据所属模块外层名称展开
# V import Test.Bizcase.Import ==> import Run.Test.Bizcase.Import 
# defmodule Run do
#   defmodule Test.Fuck do
#     #   @moduledoc(false)
#     #   use(ExUnit.Case, async: true)
#       import Test.Bizcase.Import
#   end
# end

defmodule Hahah do
  defmodule Gan do 
    import Test.Bizcase.Import
  end
end


