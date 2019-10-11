defmodule LanguageConfig do
  defstruct [:file_extension, :prettyprint_id, :display_name, :markdown_id, display_primary: false]
end

defmodule GuygwWeb.AlgoView do
  use GuygwWeb, :view
  require File
  require Earmark

  @static_main_path "./assets/static/blog_posts/algo/"
  @static_algo_path "./assets/static/blog_posts/algo/algorithms/"
  @static_ds_path "./assets/static/blog_posts/algo/datastructures/"
  @supported_programming_languages [
    python: %LanguageConfig{
      file_extension: ".py",
      prettyprint_id: "lang-python",
      markdown_id: "python",
      display_name: "Python",
      display_primary: true
    },
    elixir: %LanguageConfig{
      file_extension: ".ex",
      prettyprint_id: "lang-ex",
      markdown_id: "elixir",
      display_name: "Elixir"
    },
    golang: %LanguageConfig{
      file_extension: ".go",
      prettyprint_id: "lang-go",
      markdown_id: "golang",
      display_name: "Go"
    }
  ]

  defp find_path(category, topic) do
    dir =
      case category do
        "algorithms" -> @static_algo_path
        "datastructures" -> @static_ds_path
      end
    dir <> topic
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  def supported_programming_languages do
    Keyword.keys(@supported_programming_languages)
  end

  def compose_code_example(language, category, topic) do

    if Keyword.has_key?(@supported_programming_languages, language) do

      language_params = @supported_programming_languages[language]
      case File.read(find_path(category, topic) <> "/implementation#{language_params.file_extension}") do
        {:ok, contents} ->
          compose_code_example_html(contents, language_params)
        {:error, _} ->
          nil
      end

    else
      nil
    end

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

  def compose_code_example_html(code, language_params) do
    id = random_string(10)
    checked = if language_params.display_primary, do: "checked", else: ""

    "<input name=\"tabbed\" id=\"#{id}\" type=\"radio\" #{checked}>
    <section>
      <h1>
        <label for=\"#{id}\">#{language_params.display_name}</label>
      </h1>
      <div>
        <pre class=\"prettyprint #{language_params.prettyprint_id}\">
#{code}
        </pre>
      </div>
    </section>"
    |> Phoenix.HTML.raw
  end
end
