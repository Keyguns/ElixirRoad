#编译运行到同一个命名空间后可以使用
defmodule A do
import UseImport

  def foo() do
    out()
  end
end
#
