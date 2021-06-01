defmodule Calorie.Repo.Migrations.CreateBmrs do
  use Ecto.Migration

  def change do
    create table(:physical_profile) do
      add :weight, :integer
      add :age, :integer
      add :height, :integer
      add :sex, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:physical_profile, [:user_id])
  end
end
