defmodule Phantasma.Content.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :host, :string
    field :url, :string

    belongs_to :post, Phantasma.Content.Post

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:host, :url])
    |> validate_required([:host, :url])
  end
end
