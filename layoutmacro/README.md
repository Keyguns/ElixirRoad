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

deflayout ExpandByFunction do
  message("Happy","Haha")
  message("Angry"，"tired")
end

# 需要根据具体情况选择解决方案，方案很难具备普适性，所以不要用普适性的思维思考问题
# 没有银弹

# bizcase
# message(:actor,usecase_func)    ==> invoke usecase_func

# usecase
# message(:be_invoke_int_func,parameter)

# interface
# interface(:be_invoked_func,func_name)  


def message("emotion","status") do
  {}
end


==>

defmodule ExpandByFunction do

  
  
end
  
```