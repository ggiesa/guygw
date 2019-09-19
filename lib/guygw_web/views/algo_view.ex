defmodule GuygwWeb.AlgoView do
  use GuygwWeb, :view
  require File
  require Earmark

  @static_main_path "./assets/static/blog_posts/algo/"
  @static_algo_path "./assets/static/blog_posts/algo/algorithms/"
  @static_ds_path "./assets/static/blog_posts/algo/datastructures/"

  defp find_path(category, topic) do
    dir =
      case category do
        "algorithms" -> @static_algo_path
        "datastructures" -> @static_ds_path
      end
    dir <> topic
  end

  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_python(category, topic) do
    File.read!(find_path(category, topic) <> "/implementation.py")
  end


  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_elixir(category, topic) do
    File.read!(find_path(category, topic) <> "/implementation.ex")
  end

  @doc """
  Return formatted string of code to display in code example tab
  """
  def compose_golang(category, topic) do
    File.read!(find_path(category, topic) <> "/implementation.go")
  end

  @doc """
  Returns list of all algorithm/datastructure topics to display in sidebar
  """
  def get_all_datastructures_topics do
    File.ls!(@static_ds_path)
    |> Enum.filter(fn f -> !String.contains?(f, ".") end)
  end

  @doc """
  Returns list of all algorithm/datastructure topics to display in sidebar
  """
  def get_all_algorithms_topics do
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
  Parse html string, replacing standard code blocks with google code-prettify friendly classes
  """
  defp format_code_blocks(html) do
    html
      |> String.replace("<pre><code class=\"python", "<pre class=\"prettyprint lang-python")
      |> String.replace("<pre><code class=\"elixir", "<pre class=\"prettyprint lang-ex")
      |> String.replace("<pre><code class=\"golang", "<pre class=\"prettyprint lang-go")
      |> String.replace("</code>", "")
  end

  @doc """
  Convert markdown to html, add code highlighting
  """
  defp convert_markdown_to_html(path) do
    {err, markdown} = File.read(path)
    if err != :ok do
      nil
    else
      html =
        Earmark.as_html!(markdown)
        |> format_code_blocks()
      {:safe, html}
    end
  end

  @doc """
  Convert a
  """
  def render_markdown_contents("homepage") do
    convert_markdown_to_html(@static_main_path <> "/homepage.md")
  end

  def render_markdown_contents(category, topic) do
    convert_markdown_to_html(find_path(category, topic) <> "/copy.md")
  end
end
