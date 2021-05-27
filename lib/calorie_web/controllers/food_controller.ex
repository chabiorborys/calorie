defmodule CalorieWeb.FoodController do
  use CalorieWeb, :controller

  alias Calorie.Products
  alias Calorie.Products.Food

  def index(conn, _params) do
    foods = Products.list_foods()
    render(conn, "index.html", foods: foods)
  end

  def new(conn, _params) do
    changeset = Products.change_food(%Food{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"food" => food_params}) do
    case Products.create_food(food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food created successfully.")
        |> redirect(to: Routes.food_path(conn, :show, food))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    food = Products.get_food!(id)
    render(conn, "show.html", food: food)
  end

  def edit(conn, %{"id" => id}) do
    food = Products.get_food!(id)
    changeset = Products.change_food(food)
    render(conn, "edit.html", food: food, changeset: changeset)
  end

  def update(conn, %{"id" => id, "food" => food_params}) do
    food = Products.get_food!(id)

    case Products.update_food(food, food_params) do
      {:ok, food} ->
        conn
        |> put_flash(:info, "Food updated successfully.")
        |> redirect(to: Routes.food_path(conn, :show, food))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", food: food, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    food = Products.get_food!(id)
    {:ok, _food} = Products.delete_food(food)

    conn
    |> put_flash(:info, "Food deleted successfully.")
    |> redirect(to: Routes.food_path(conn, :index))
  end
end
