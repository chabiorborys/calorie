defmodule Calorie.Repo.Migrations.CreateUsersFoods do
  use Ecto.Migration


  def change do
    create table(:users_foods) do
      add :user_id, references(:users)
      add :food_id, references(:foods)
      timestamps()
    end


    create(index(:users_foods, [:user_id]))
    create(index(:users_foods, [:food_id]))

    create unique_index(:users_foods, [:user_id, :food_id], name: :user_id_food_id_unique_index)
  end
end
