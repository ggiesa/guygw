

defmodule Stack do
  @moduledoc """
  A simple stack implementation using Lists
  """

  defstruct [data: [], size: 0]

  def new do; %Stack{} end

  def push(stack, item) do
    # Because Elixir's lists are linked lists under the hood, we prepend rather than append.
    %Stack{
      data: [item | stack.data],
      size: stack.size + 1
    }
  end

  def pop(%Stack{ data: [] }) do; {:empty, new()} end
  def pop(%Stack{ data: [head] }) do; {head, new()} end
  def pop(%Stack{ data: [head | tail], size: size }) do
    {head, %Stack{data: tail, size: size-1}}
  end

  def peek(%Stack{}) do; :empty end
  def peek(%Stack{data: [head | _tail]}) do; head end
end
