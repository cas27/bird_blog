defmodule BirdBlog.PostTest do
  use BirdBlog.ModelCase
  import Ecto.Changeset, only: [fetch_field: 2]

  alias BirdBlog.Post
  alias BirdBlog.Repo

  @valid_attrs %{body: "some content", title: "some content", slug: "what-up"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "two posts with the same slug" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    Repo.insert!(changeset)

    changeset2 = Post.changeset(%Post{}, @valid_attrs)
    refute changeset2.valid?
  end

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, Map.delete(@valid_attrs, :slug))
    assert fetch_field(changeset, :slug) == {:changes, "some-content"}
  end
end
