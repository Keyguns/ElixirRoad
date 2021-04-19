defmodule MacroMacro do
  defmacro test_idea(module_name,do: clause)do
    defmodule(unquote(module_name)) do
      quote do
        IO.inspect("Today you create your own framework!")
        
    end
  end
end

defmodule Parse do
  def getmethod do
    
  end
end

# 


# test_ides VeryHappy



#需要对宏有很深的理解