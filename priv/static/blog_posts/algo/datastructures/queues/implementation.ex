defmodule Queue do
  defstruct [data: [], size: 0]

  def new do; %Queue{} end

  def enqueue(queue, item)
  def enqueue(%Queue{data: data, size: size}, item) do
    %Queue{data: [item | data], size: size+1}
  end

  def dequeue(queue)
  def dequeue(%Queue{data: []}) do; {:empty, new()} end
  def dequeue(%Queue{data: data, size: size}) do
    {val, data} = pop_last_elem(data, [])
    {val, %Queue{data: data, size: size-1}}
  end

  def empty?(queue)
  def empty?(%Queue{size: 0}) do; true end
  def empty?(%Queue{}) do; false end

  defp pop_last_elem(list, remainder)
  defp pop_last_elem([head], remainder) do
    {head, :lists.reverse(remainder)}
  end

  defp pop_last_elem([head | tail], remainder) do
    pop_last_elem(tail, [head | remainder])
  end
end


defmodule Benchmark do
  def measure(function) do
    function
    |> :timer.tc
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
