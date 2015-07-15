defmodule BirdBlog.PageController do
  use BirdBlog.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
