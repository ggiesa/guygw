defmodule GuygwWeb.AlgoController do
  use GuygwWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def serve_algorithm_topic(conn, %{"topic" => topic, "category" => category}) do
    conn
    |> put_layout(false)
    |> render("topic.html", topic: topic, category: category)
  end

end
