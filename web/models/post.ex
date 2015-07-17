defmodule BirdBlog.Post do
  use BirdBlog.Web, :model
  alias BirdBlog.Repo

  before_insert :generate_slug

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :body, :string

    timestamps
  end

  @required_fields ~w(title body)
  @optional_fields ~w(slug)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_unique(:slug, on: Repo)
  end

  def title_to_slug(title) do
    title
    |> String.downcase
    |> String.replace(" ", "-")
  end

  def unique_slug({_, title}) do
    title = title_to_slug(title)
    exists = Repo.get_by(BirdBlog.Post, slug: title)
    if exists do
      unique_slug({:error, "#{title}-#{:random.uniform(99999)}"})
    else
      title
    end
  end

  defp generate_slug(changeset) do
    case fetch_field(changeset, :slug) do
      {:changes, nil} ->
        slug = unique_slug(fetch_field(changeset, :title))
        changeset = put_change(changeset, :slug, slug)
      _ ->
        changeset
     end
  end

end
