defmodule GuygwWeb.BlogController do
  use GuygwWeb, :controller

  def index(conn, _) do
    conn
    |> put_layout(false)
    |> render("index.html", category: "dsa")
  end

  def serve_blog_topic(conn, %{"category" => category, "topic" => topic, "sub_topic" => sub_topic}) do
    conn
    |> put_layout(false)
    |> render("topic.html", category: category, topic: topic, sub_topic: sub_topic)
  end
end
