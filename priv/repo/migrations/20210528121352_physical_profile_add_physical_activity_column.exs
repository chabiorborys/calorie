defmodule Calorie.Repo.Migrations.PhysicalProfileAddPhysicalActivityColumn do
  use Ecto.Migration

  def change do
    alter table("physical_profile") do
      add :physical_activity, :integer
    end
  end
end
