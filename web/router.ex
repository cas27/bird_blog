defmodule BirdBlog.Router do
  use BirdBlog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BirdBlog do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    resources "/posts", PostController
    get "/hello/:msg", HelloController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", BirdBlog do
  #   pipe_through :api
  # end
end
