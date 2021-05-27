defmodule CalorieWeb.FoodControllerTest do
  use CalorieWeb.ConnCase

  alias Calorie.Products

  @create_attrs %{calories: 42, name: "some name"}
  @update_attrs %{calories: 43, name: "some updated name"}
  @invalid_attrs %{calories: nil, name: nil}

  def fixture(:food) do
    {:ok, food} = Products.create_food(@create_attrs)
    food
  end

  describe "index" do
    test "lists all foods", %{conn: conn} do
      conn = get(conn, Routes.food_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Foods"
    end
  end

  describe "new food" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.food_path(conn, :new))
      assert html_response(conn, 200) =~ "New Food"
    end
  end

  describe "create food" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.food_path(conn, :create), food: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.food_path(conn, :show, id)

      conn = get(conn, Routes.food_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Food"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.food_path(conn, :create), food: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Food"
    end
  end

  describe "edit food" do
    setup [:create_food]

    test "renders form for editing chosen food", %{conn: conn, food: food} do
      conn = get(conn, Routes.food_path(conn, :edit, food))
      assert html_response(conn, 200) =~ "Edit Food"
    end
  end

  describe "update food" do
    setup [:create_food]

    test "redirects when data is valid", %{conn: conn, food: food} do
      conn = put(conn, Routes.food_path(conn, :update, food), food: @update_attrs)
      assert redirected_to(conn) == Routes.food_path(conn, :show, food)

      conn = get(conn, Routes.food_path(conn, :show, food))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, food: food} do
      conn = put(conn, Routes.food_path(conn, :update, food), food: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Food"
    end
  end

  describe "delete food" do
    setup [:create_food]

    test "deletes chosen food", %{conn: conn, food: food} do
      conn = delete(conn, Routes.food_path(conn, :delete, food))
      assert redirected_to(conn) == Routes.food_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.food_path(conn, :show, food))
      end
    end
  end

  defp create_food(_) do
    food = fixture(:food)
    {:ok, food: food}
  end
end
