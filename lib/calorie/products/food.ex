defmodule Calorie.Products.Food do
  import Ecto.Query
  import Ecto
  use Ecto.Schema
  import Ecto.Changeset

  schema "foods" do
    field :calories, :integer
    field :name, :string
    many_to_many(
      :users,
      Calorie.Accounts.User,
      join_through: "movies_actors",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(food, attrs) do
    food
    |> cast(attrs, [:name, :calories])
    |> validate_required([:name, :calories])
  end

  def alphabetical(query) do
    from f in query, order_by: f.name
  end

  def names_and_ids(query) do
    from c in query, select: {c.name, c.id}
  end
end
