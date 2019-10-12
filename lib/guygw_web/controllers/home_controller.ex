defmodule GuygwWeb.HomeController do
  use GuygwWeb, :controller

  def index(conn, _) do
    conn
    |> put_layout(false)
    |> render("home.html")
  end
  
end
