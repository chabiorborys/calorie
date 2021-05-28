defmodule Calorie.Repo.Migrations.BmrsAddPhysicalActivityColumn do
  use Ecto.Migration

  def change do
    alter table("bmrs") do
      add :physical_activity, :integer
    end
  end
end
