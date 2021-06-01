defmodule Calorie.Repo.Migrations.PhysicalProfileChangePhysicalActivityColumn do
  use Ecto.Migration

  def change do
    alter table(:physical_profile) do
      modify :physical_activity, :string
    end
  end
end
