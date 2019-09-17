defmodule GuygwWeb.PageController do
  use GuygwWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
