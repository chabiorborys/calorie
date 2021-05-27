defmodule CalorieWeb.BmrControllerTest do
  use CalorieWeb.ConnCase

  alias Calorie.Cpm

  @create_attrs %{age: 42, height: 42, weight: 42}
  @update_attrs %{age: 43, height: 43, weight: 43}
  @invalid_attrs %{age: nil, height: nil, weight: nil}

  def fixture(:bmr) do
    {:ok, bmr} = Cpm.create_bmr(@create_attrs)
    bmr
  end

  describe "index" do
    test "lists all bmrs", %{conn: conn} do
      conn = get(conn, Routes.bmr_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Bmrs"
    end
  end

  describe "new bmr" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.bmr_path(conn, :new))
      assert html_response(conn, 200) =~ "New Bmr"
    end
  end

  describe "create bmr" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bmr_path(conn, :create), bmr: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.bmr_path(conn, :show, id)

      conn = get(conn, Routes.bmr_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Bmr"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bmr_path(conn, :create), bmr: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Bmr"
    end
  end

  describe "edit bmr" do
    setup [:create_bmr]

    test "renders form for editing chosen bmr", %{conn: conn, bmr: bmr} do
      conn = get(conn, Routes.bmr_path(conn, :edit, bmr))
      assert html_response(conn, 200) =~ "Edit Bmr"
    end
  end

  describe "update bmr" do
    setup [:create_bmr]

    test "redirects when data is valid", %{conn: conn, bmr: bmr} do
      conn = put(conn, Routes.bmr_path(conn, :update, bmr), bmr: @update_attrs)
      assert redirected_to(conn) == Routes.bmr_path(conn, :show, bmr)

      conn = get(conn, Routes.bmr_path(conn, :show, bmr))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, bmr: bmr} do
      conn = put(conn, Routes.bmr_path(conn, :update, bmr), bmr: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Bmr"
    end
  end

  describe "delete bmr" do
    setup [:create_bmr]

    test "deletes chosen bmr", %{conn: conn, bmr: bmr} do
      conn = delete(conn, Routes.bmr_path(conn, :delete, bmr))
      assert redirected_to(conn) == Routes.bmr_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.bmr_path(conn, :show, bmr))
      end
    end
  end

  defp create_bmr(_) do
    bmr = fixture(:bmr)
    {:ok, bmr: bmr}
  end
end
