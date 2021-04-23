
defmodule Mod do
  defmacro definfo do
    IO.puts "In macro's context (#{__MODULE__})." 
### context 1  with caller space
    quote do
      IO.puts "In caller's context (#{__MODULE__})." 
### context 2  with definition caller
      def friendly_info do
        IO.puts """ 
        My name is #{__MODULE__}
        My functions are #{IO.inspect :functions}
        """
      end
    end
  end
end

defmodule MyModule do
  require Mod
  Mod.definfo
end

MyModule.friendly_info


