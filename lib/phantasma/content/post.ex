defmodule Phantasma.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :name, :string
    field :type, Ecto.Enum, values: [:image, :video]

    has_many :submissions, Phantasma.Content.Submission
    has_many :links, Phantasma.Content.Link

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
  end
end
