defmodule Calorie.Repo.Migrations.BmrsChangePhysicalActivityColumn do
  use Ecto.Migration

  def change do
    alter table(:bmrs) do
      modify :physical_activity, :string
    end
  end
end
