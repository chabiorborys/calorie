defmodule Calorie.UserFoods do
  @moduledoc """
  The UserFood context
  """
  import Ecto.Query, warn: false
  alias Calorie.Repo

  alias Calorie.UsersFoods.UserFood



  @doc """
  Returns the list of user foods.
  """
  def list_user_foods do
    Repo.all(UserFood)
  end

  @doc """
  Gets a single user food.
  """
  def get_user_food!(id), do: Repo.get!(UserFood, id)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user food changes.
  """

  def change_user_food(%UserFood{} = user_food) do
    UserFood.changeset(user_food, %{})
  end

  def create_foods(attrs \\ %{}) do
    %UserFood{}
    |> UserFood.changeset(attrs)
    |> Repo.insert()
  end

end
