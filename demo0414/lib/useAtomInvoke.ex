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
  @name %{name: "benladeng"}

  def run do
    IO.inspect(quote do be_invoke() end)
    invoke_by_atom(:haha)
    {:haha,[],[]}
  end

  def func_name(),do: @name
  # def not_direct_use_attr()  

end


AtomInvoke.run()
IO.inspect(AtomInvoke.func_name.name)
# 宏 和 模式匹
