defmodule Calorie.Cpm.PhysicalProfile do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "physical_profile" do
    field :age, :integer
    field :height, :integer
    field :weight, :integer
    field :sex, :string
    field :physical_activity, :string
    field :cpm, :float
    field :bmr, :float
    belongs_to :user, Calorie.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(physical_profile, attrs) do
    physical_profile
    |> cast(attrs, [:weight, :age, :height, :sex, :physical_activity, :cpm, :bmr])
    |> validate_required([:weight, :age, :height, :sex, :physical_activity])
  end
end
