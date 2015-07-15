defmodule BirdBlog.PageControllerTest do
  use BirdBlog.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome Cory!"
  end
end
