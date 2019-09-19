defmodule GuygwWeb.AlgoView do
  use GuygwWeb, :view
  require File
  require Earmark

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
    |> Enum.filter(fn f -> !String.contains?(f, ".") end)
  end

  @doc """
  Capitalize, replace underscores with spaces
  """
  def format_topic_for_disp(string) do
    string
    |> String.replace("_", " ")
    |> String.capitalize
  end

  @doc """
  Convert a
  """
  def render_markdown_contents(topic) do
    {err, markdown} = File.read(@static_algo_path <> topic <> "/copy.md")
    if err != :ok do
      nil
    else
      html =
        Earmark.as_html!(markdown)
        |> String.replace("<pre><code class=\"python", "<pre class=\"prettyprint lang-python")
        |> String.replace("<pre><code class=\"elixir", "<pre class=\"prettyprint lang-ex")
        |> String.replace("<pre><code class=\"golang", "<pre class=\"prettyprint lang-go")
        |> String.replace("</code>", "")
      {:safe, html}
      # {:safe, Earmark.as_html!(markdown)}
    end
  end
end
