defmodule ListTest do
  #List.Keyfind 只能遍历一层,且只能匹配第一个元素，
  def out() do
    list = [{:a,:b,:sduhfiahfuhai},[:cde,:a,:d],:c,:d]
    List.keyfind(list,:cde,1234)
    |>IO.inspect()
  end
end



# ListOne two()
defmodule KeywordTest do
  ListTest.out()
end
