defmodule Guygw.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do

    # Generate static config file with blog topic options
    BlogTopics.generate_config()

    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Guygw.Repo,
      # Start the endpoint when the application starts
      GuygwWeb.Endpoint
      # Starts a worker by calling: Guygw.Worker.start_link(arg)
      # {Guygw.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Guygw.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GuygwWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule BlogTopics do
  @blog_location "assets/static/blog/"
  @config_location "lib/guygw/blog_topics.ex"

  defp list_subdirs(path) do
    File.ls!(path)
    |> Enum.filter(fn f -> !String.contains?(f, ".") end)
  end

  def get_categories do
    list_subdirs(@blog_location)
  end

  def get_topics(category) do
    list_subdirs(@blog_location <> category)
  end

  def get_sub_topics(category, topic) do
    list_subdirs(@blog_location <> category <> "/" <> topic)
  end

  def compose_blog_topics do
    Map.new(get_categories(), fn category -> {category,
      Map.new(get_topics(category), fn topic -> {topic,
        get_sub_topics(category, topic)} end
      )} end
    )
  end

  def generate_config do
    code = "
    defmodule BlogConfig do
      @blog_topics #{inspect compose_blog_topics()}

      def blog_topics do
        @blog_topics
      end
    end
    "
    File.write!(@config_location, code)
    Code.compile_file(@config_location)
    Code.ensure_loaded(BlogConfig)
  end

end
