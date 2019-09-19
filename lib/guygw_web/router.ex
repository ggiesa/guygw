defmodule GuygwWeb.Router do
  use GuygwWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GuygwWeb do
    pipe_through :browser

    get "/", AlgoController, :index
    get "/:category/:topic", AlgoController, :serve_algorithm_topic
  end

  # Other scopes may use custom stacks.
  # scope "/api", GuygwWeb do
  #   pipe_through :api
  # end
end
