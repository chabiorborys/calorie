defmodule Calorie.Repo.Migrations.CreateBmrs do
  use Ecto.Migration

  def change do
    create table(:bmrs) do
      add :weight, :integer
      add :age, :integer
      add :height, :integer
      add :sex, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:bmrs, [:user_id])
  end
end
