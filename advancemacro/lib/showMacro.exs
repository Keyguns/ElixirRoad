### 宏是干净的不能使用context以外的内容

defmodule ShowMacro do
  defmacro show(clause)do
    IO.inspect(clause)
    :a
  end

  defmacro haha({fun_head,_,[actor]},do: clause)do
    quote do
      def unquote(fun_head)(unquote(actor))do
        IO.inspect(unquote(actor))
      end 
    end
  end

### 宏是干净的
#   defmacro sad(func_head,do: clause)do
#     quote do
#       def unquote(func_head)do
#         IO.inspect(unquote(actor))
#       end 
#     end
#   end

end

defmodule Run do
  import ShowMacro
  haha happy(actor) do
    IO.inspect("Fuck dead Line")  
  end 

end

Run.happy("BenLaDeng")