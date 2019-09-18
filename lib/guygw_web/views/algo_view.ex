defmodule GuygwWeb.AlgoView do
  use GuygwWeb, :view
  require File

  @static_algo_path "./assets/static/blog_posts/algo/"

  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_python(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.py")
  end


  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_elixir(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.ex")
  end

  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_golang(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.go")
  end

  @doc """
  Returns list of all algorithm/datastructure topics to display in sidebar
  """
  def get_all_topics do
    File.ls!(@static_algo_path)
  end
end
