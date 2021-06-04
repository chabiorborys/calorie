defmodule CalorieWeb.PageControllerTest do
  use CalorieWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Calories!"
  end
end
