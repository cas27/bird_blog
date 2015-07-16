defmodule BirdBlog.Post do
  use BirdBlog.Web, :model

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
  end

  def title_to_slug({_, title}) do
    title
    |> String.downcase
    |> String.replace(" ", "-")
  end

  defp generate_slug(changeset) do
    case fetch_field(changeset, :slug) do
      {:changes, nil} ->
        changeset = put_change(changeset,
                               :slug,
                               title_to_slug(fetch_field(changeset, :title)))
      _ ->
        changeset
     end
  end

end
