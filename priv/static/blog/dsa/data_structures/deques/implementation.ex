defmodule Deque do

  defstruct [data: [], size: 0]

  def new do; %Deque{} end

  def add_front(%Deque{data: data, size: size}, item) do
    %Deque{data: data ++ [item], size: size+1}
  end

  def add_rear(%Deque{data: data, size: size}, item) do
    %Deque{data: [item | data], size: size+1}
  end

  def remove_rear(%Deque{data: []}) do; {:empty, new()} end
  def remove_rear(%Deque{data: [head | tail], size: size}) do
    {head, %Deque{data: tail, size: size-1}}
  end

  def remove_front(%Deque{data: []}) do; {:empty, new()} end
  def remove_front(%Deque{data: data, size: size}) do
    {val, data} = pop_last_elem(data)
    {val, %Deque{data: data, size: size-1}}
  end

  defp pop_last_elem(list, remaining \\ [])
  defp pop_last_elem([head], remaining) do; {head, :lists.reverse(remaining)} end
  defp pop_last_elem([head | tail], remaining) do; pop_last_elem(tail, [head | remaining]) end
end


defmodule Test do
  require Deque

  def test do
    d = Deque.new
    IO.inspect(d)

    d = Deque.add_front(d, 1)
    d = Deque.add_front(d, 2)
    d = Deque.add_front(d, 3)
    IO.inspect(d)

    d = Deque.add_rear(d, 1)
    d = Deque.add_rear(d, 2)
    d = Deque.add_rear(d, 3)
    IO.inspect(d)

    {val, d} = Deque.remove_rear(d)
    IO.inspect({val, d})
    {val, d} = Deque.remove_rear(d)
    IO.inspect({val, d})
    {val, d} = Deque.remove_rear(d)
    IO.inspect({val, d})

    {val, d} = Deque.remove_front(d)
    IO.inspect({val, d})
    {val, d} = Deque.remove_front(d)
    IO.inspect({val, d})
    {val, d} = Deque.remove_front(d)
    IO.inspect({val, d})

    {val, d} = Deque.remove_front(d)
    IO.inspect({val, d})
    {val, d} = Deque.remove_rear(d)
    IO.inspect({val, d})


  end
end
