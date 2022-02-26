defmodule Phantasma.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :host, :string
      add :url, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:links, [:post_id])
  end
end
