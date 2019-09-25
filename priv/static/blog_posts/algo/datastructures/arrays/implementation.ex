defmodule DynamicArray do
  @moduledoc """
  A simple and contrived dynamic list implementation in Elixir. Similar to the
  basic datastructures in Elixir, this implementation uses an underlying erlang library. 

  """

  defstruct [data: :array.new(1), length: 0, capacity: 1]

  def new do
    %DynamicArray{}
  end

  def append(array, item) do
    array =
      if array.length == array.capacity do
        resize(array, array.capacity * 2)
      else
        array
      end

    %DynamicArray{
      data: :array.set(array.length, item, array.data),
      length: array.length + 1,
      capacity: array.capacity
    }
  end

  def get(array, ind) do
    if ind > array.length - 1 do
      :error
    else
      :array.get(ind, array.data)
    end
  end

  defp resize(array, new_capacity) do
    %DynamicArray{
      data: :array.resize(new_capacity, array.data),
      length: array.length,
      capacity: new_capacity
    }
  end
end
