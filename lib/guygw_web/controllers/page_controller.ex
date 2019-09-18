defmodule GuygwWeb.PageController do
  use GuygwWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

end
