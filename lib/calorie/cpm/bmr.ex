defmodule Calorie.Cpm.Bmr do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "bmrs" do
    field :age, :integer
    field :height, :integer
    field :weight, :integer
    field :sex, :string
    field :physical_activity, :string
    belongs_to :user, Calorie.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(bmr, attrs) do
    bmr
    |> cast(attrs, [:weight, :age, :height, :sex, :physical_activity])
    |> validate_required([:weight, :age, :height, :sex, :physical_activity])
  end

  def sorted(query) do
    from p in query,
    order_by: [desc: p.inserted_at]
  end
end
