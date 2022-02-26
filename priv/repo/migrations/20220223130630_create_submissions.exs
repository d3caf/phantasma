defmodule Phantasma.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table(:submissions) do
      add :subs, {:array, :string}
      add :status, :string
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:submissions, [:post_id])
  end
end
