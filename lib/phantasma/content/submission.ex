defmodule Phantasma.Content.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "submissions" do
    field :status, Ecto.Enum, values: [:posted, :pending, :removed, :draft, :scheduled]
    field :subs, {:array, :string}

    belongs_to :post, Phantasma.Content.Post

    timestamps()
  end

  @doc false
  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:subs, :status])
    |> validate_required([:subs, :status])
  end
end
