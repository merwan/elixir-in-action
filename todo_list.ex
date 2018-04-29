defmodule TodoList do
  def new(), do: %{}

  def add_entry(todo_list, date, title) do
    Map.update(
      todo_list,
      date,
      [title],
      fn titles -> [title | titles] end
    )
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end

date = ~D[2018-04-29]
IO.puts TodoList.new |>
TodoList.add_entry(date, "Dentist") |>
TodoList.add_entry(date, "Football") |>
TodoList.entries(date)
