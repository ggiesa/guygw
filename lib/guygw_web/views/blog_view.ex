
defmodule GuygwWeb.BlogView do
  use GuygwWeb, :view
  require BlogConfig
  require File
  require Earmark


  @blog_location "./assets/static/blog/"
  @code_example_filename "/implementation"
  @markdown_filename "/copy.md"

  @static_main_path "./assets/static/blog/dsa/"
  @static_algo_path "./assets/static/blog/dsa/algorithms/"
  @static_ds_path "./assets/static/blog/dsa/datastructures/"


  def find_path(category, topic, sub_topic) do
    Path.join([@blog_location, category, topic, sub_topic])
  end

  @doc """
  Capitalize, replace underscores with spaces
  """
  def format_topic_for_disp(string) do
    string
    |> String.split("_")
    |> Enum.map_join(" ", fn s -> String.capitalize(s) end)
  end

  def get_categories do
    Map.keys(BlogConfig.blog_topics)
  end

  def get_topics(category) do
    Map.keys(BlogConfig.blog_topics[category])
  end

  def get_sub_topics(category, topic) do
    BlogConfig.blog_topics[category][topic]
  end

  def render_markdown_contents("homepage") do
    MarkdownParser.convert_markdown_to_html(@static_main_path <> "/homepage.md")
  end

  def render_markdown_contents(category, topic, sub_topic) do
    path = find_path(category, topic, sub_topic) <> @markdown_filename
    MarkdownParser.convert_markdown_to_html(path)
  end

  def render_code_example(language, category, topic, sub_topic) do
    path = find_path(category, topic, sub_topic) <> @code_example_filename
    CodeFormatter.compose_code_example(language, path)
  end
end


defmodule LanguageConfig do
  defstruct [
    :file_extension,
    :prettyprint_id,
    :display_name,
    :markdown_id,
    display_primary: false
  ]
end


defmodule CodeConfig do

  @language_config [
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

  def supported_programming_languages do
    Keyword.keys(@language_config)
  end

  def language_config do
    @language_config
  end
end


defmodule MarkdownParser do
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
  def convert_markdown_to_html(path) do
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
end


defmodule CodeFormatter do

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
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
    |> Phoenix.HTML.raw()
  end

  def compose_code_example(language, path) do

    if language in CodeConfig.supported_programming_languages do
      language_params = CodeConfig.language_config[language]

      case File.read(path <> language_params.file_extension) do
        {:ok, ""} -> nil
        {:error, _} -> nil
        {:ok, contents} -> compose_code_example_html(contents, language_params)
      end
    else
      nil
    end
  end
end
