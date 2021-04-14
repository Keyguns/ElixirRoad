defmodule AtomInvoke do 
  def be_invoke do
    IO.inspect(:ok)
  end
  def haha do
    IO.inspect(:hahaha)
  end
  defmacro invoke_by_atom(func_name) do 
    {func_name,["meta data is use less"],[]}
  end 
  def run do
    IO.inspect(quote do be_invoke() end)
    invoke_by_atom(:haha)
  end

  
end


AtomInvoke.run()

# 宏 和 模式匹配