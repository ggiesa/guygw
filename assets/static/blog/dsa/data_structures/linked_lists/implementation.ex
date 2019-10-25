
defmodule LinkedList do
  defstruct [:head, size: 0]

  defmodule Node do
    defstruct [:value, :next]
  end

  def new do; %LinkedList{} end

  def prepend(list, item)
  def prepend(%LinkedList{head: head, size: size}, item) do
    %LinkedList{head: do_prepend(head, item), size: size+1}
  end

  def append(list, item)
  def append(%LinkedList{head: head, size: size}, item) do
    %LinkedList{head: do_append(head, item), size: size + 1}
  end

  def pop_first(list)
  def pop_first(%LinkedList{size: 0}) do; {:empty, %LinkedList{}} end
  def pop_first(%LinkedList{head: head, size: size}) do
    {head.value, %LinkedList{head: head.next, size: size-1}}
  end

  def pop_last(list)
  def pop_last(%LinkedList{head: nil}) do; {:empty, %LinkedList{}} end
  def pop_last(%LinkedList{head: head, size: size}) do
    {val, nodes} = do_pop_at(head, size-1)
    {val, %LinkedList{head: nodes, size: size-1}}
  end

  def pop_at(list, ind)
  def pop_at(%LinkedList{head: nil}, _) do; {:empty, %LinkedList{}} end
  def pop_at(%LinkedList{head: head, size: size}, ind) do
    {val, nodes} = do_pop_at(head, ind)
    {val, %LinkedList{head: nodes, size: size-1}}
  end

  def update_at(list, ind, item)
  def update_at(%LinkedList{head: head, size: size}, ind, item) do
    %LinkedList{head: do_update_at(head, ind, item), size: size}
  end

  def get(list, ind) do
    do_get(list.head, ind)
  end

  def reverse(%LinkedList{head: head, size: size}) do
    case size do
      0 -> %LinkedList{}
      1 -> %LinkedList{head: head, size: size}
      _ -> %LinkedList{head: reverse_nodes(head), size: size}
    end
  end

  defp reverse_nodes(head) do
    do_prepend(%Node{value: head.value}, head.next.value)
      |> reverse_nodes(head.next.next)
  end

  defp reverse_nodes(head, nil) do; head end
  defp reverse_nodes(head, tail) do
    do_prepend(head, tail.value)
      |> reverse_nodes(tail.next)
  end

  defp do_prepend(head, item) do
    %Node{value: item, next: head}
  end

  defp do_get(head, 0) do; head.value end
  defp do_get(head, ind) do
    do_get(head.next, ind-1)
  end

  defp do_append(nil, item) do; %Node{value: item} end
  defp do_append(head, item) do
    %Node{value: head.value, next: do_append(head.next, item)}
  end

  defp do_update_at(head, ind, item)
  defp do_update_at(head, 0, item) do; %Node{value: item, next: head.next} end
  defp do_update_at(head, ind, item) do
    %Node{value: head.value, next: do_update_at(head.next, ind-1, item)}
  end

  defp do_pop_at(head, ind)
  defp do_pop_at(head, 0) do; {head.value, head.next} end
  defp do_pop_at(head, ind) do
    case do_pop_at(head.next, ind-1) do
      {target, next} -> {target, %Node{value: head.value, next: next}}
      next -> %Node{value: head.value, next: next}
    end
  end

  defimpl Inspect, for: LinkedList do
    def inspect(list, _) do
      "[" <> String.trim_trailing(values_to_string(list.head), ", ") <> "]"
    end

    defp values_to_string(head) do
        case head do
          nil -> ""
          _ -> to_string(head.value) <> ", " <> values_to_string(head.next)
        end
    end
  end
end


defmodule Test do
  def test do
    l = LinkedList.new
    l = LinkedList.append(l, 1)
    l = LinkedList.append(l, 2)
    l = LinkedList.append(l, 3)
    l = LinkedList.append(l, 4)

    l = LinkedList.prepend(l, 1)
    l = LinkedList.prepend(l, 2)
    l = LinkedList.prepend(l, 3)
    l = LinkedList.prepend(l, 4)

    {_val, l} = LinkedList.pop_first(l)
    {_val, l} = LinkedList.pop_last(l)
    {_val, l} = LinkedList.pop_at(l, 3)
    l = LinkedList.update_at(l, 3, "Hello!")
    IO.inspect(l)
    l = LinkedList.reverse(l)
    IO.inspect(l)
  end
end
