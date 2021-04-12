#列表中的数字值ascii码表示-——IO.puts

list = [a: 1,a: 2,a: 3]
#Keyword.get(list,:b,false) |> IO.puts

# defp get_values([{key, value} | tail], key, values)
#         defp get_values([{_, _} | tail], key, values)
#         defp get_values([], _key, values)
IO.inspect(Keyword.get_values(list,:a))
IO.puts("hahah")

# Keyword.get_values()

#打开振动
