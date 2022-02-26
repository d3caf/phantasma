defmodule Phantasma.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :type, :string

      references :submissions
      references :links

      timestamps()
    end
  end
end
