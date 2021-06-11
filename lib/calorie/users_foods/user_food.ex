defmodule Calorie.UsersFoods.UserFood do
  use Ecto.Schema
  import Ecto.Changeset

  alias Calorie.Accounts.User
  alias Calorie.Products.Food

  schema "users_foods" do
    belongs_to(:user, User)
    belongs_to(:food, Food)

    timestamps()
  end

  @required_fields ~w(user_id food_id)a
  def changeset(users_foods, params \\ %{}) do
    users_foods
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:food_id)
    |> unique_constraint([:users, :foods],
      name: :user_id_food_id_unique_index,
      message: "dupa123"
    )

  end
end
