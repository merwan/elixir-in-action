defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)

    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list
      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)
    %TodoList{todo_list | entries: new_entries}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end

date = ~D[2018-04-29]
entry = %{date: date, title: "Dentist"}
entry2 = %{date: date, title: "Football"}

todo_list = TodoList.new |> TodoList.add_entry(entry) |>
TodoList.add_entry(entry2)

IO.inspect todo_list

todo_list = TodoList.update_entry(
  todo_list,
  1,
  &Map.put(&1, :date, ~D[2018-12-20])
)

IO.inspect todo_list

todo_list = todo_list = TodoList.delete_entry(todo_list, 1)
IO.inspect todo_list
