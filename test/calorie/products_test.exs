defmodule Calorie.ProductsTest do
  use Calorie.DataCase

  alias Calorie.Products

  describe "foods" do
    alias Calorie.Products.Food

    @valid_attrs %{calories: 42, name: "some name"}
    @update_attrs %{calories: 43, name: "some updated name"}
    @invalid_attrs %{calories: nil, name: nil}

    def food_fixture(attrs \\ %{}) do
      {:ok, food} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_food()

      food
    end

    test "list_foods/0 returns all foods" do
      food = food_fixture()
      assert Products.list_foods() == [food]
    end

    test "get_food!/1 returns the food with given id" do
      food = food_fixture()
      assert Products.get_food!(food.id) == food
    end

    test "create_food/1 with valid data creates a food" do
      assert {:ok, %Food{} = food} = Products.create_food(@valid_attrs)
      assert food.calories == 42
      assert food.name == "some name"
    end

    test "create_food/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_food(@invalid_attrs)
    end

    test "update_food/2 with valid data updates the food" do
      food = food_fixture()
      assert {:ok, %Food{} = food} = Products.update_food(food, @update_attrs)
      assert food.calories == 43
      assert food.name == "some updated name"
    end

    test "update_food/2 with invalid data returns error changeset" do
      food = food_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_food(food, @invalid_attrs)
      assert food == Products.get_food!(food.id)
    end

    test "delete_food/1 deletes the food" do
      food = food_fixture()
      assert {:ok, %Food{}} = Products.delete_food(food)
      assert_raise Ecto.NoResultsError, fn -> Products.get_food!(food.id) end
    end

    test "change_food/1 returns a food changeset" do
      food = food_fixture()
      assert %Ecto.Changeset{} = Products.change_food(food)
    end
  end
end
