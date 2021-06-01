defmodule Calorie.Repo.Migrations.PhysicalProfileAddBmrCpmColumn do
  use Ecto.Migration

  def change do
    alter table("physical_profile") do
      add :cpm, :float
      add :bmr, :float
    end
  end
end
