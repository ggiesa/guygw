defmodule GuygwWeb.AlgoView do
  use GuygwWeb, :view
  require File

  @static_algo_path "./assets/static/blog_posts/algo/"
  @file_name "implementation"

  def compose_python(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.py")
  end

  def compose_elixir(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.ex")
  end

  def compose_golang(topic) do
    File.read!(@static_algo_path <> topic <> "/implementation.go")
  end
end
