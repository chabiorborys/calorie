defmodule Calorie.Cpm.Bmr do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bmrs" do
    field :age, :integer
    field :height, :integer
    field :weight, :integer
    field :sex, :string
    belongs_to :user, Calorie.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(bmr, attrs) do
    bmr
    |> cast(attrs, [:weight, :age, :height, :sex])
    |> validate_required([:weight, :age, :height, :sex])
  end
end
