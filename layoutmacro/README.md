# Layoutmacro

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `layoutmacro` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:layoutmacro, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/layoutmacro](https://hexdocs.pm/layoutmacro).

```elixir

<<<<<<< HEAD


=======
>>>>>>> 7d36d966ba576209788f0b24633a46c6e6df1607
# 需要根据具体情况选择解决方案，方案很难具备普适性，所以不要用普适性的思维思考问题
# 没有银弹

# bizcase
# message(:actor,usecase_func)    ==> invoke usecase_func

# usecase
# message(:be_invoke_int_func,parameter)

# interface
# interface(:be_invoked_func,func_name)  

deflayout ExpandByFunction do
  message("Happy","Haha")
  message("Angry"，"tired")
end
<<<<<<< HEAD

def message(emotion,status) do
  
=======


def message("emotion","status") do

>>>>>>> 7d36d966ba576209788f0b24633a46c6e6df1607
end

#==>

defmodule ExpandByFunction do
<<<<<<< HEAD
  defmacro deflayout() do
    quote do
    
    end
    
    
  end
=======
  defmacro deflayout(module_name,do: clause) do
        
  end

>>>>>>> 7d36d966ba576209788f0b24633a46c6e6df1607
end
  
```
