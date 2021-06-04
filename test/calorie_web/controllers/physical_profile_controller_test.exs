# defmodule CalorieWeb.BmrControllerTest do
#   use CalorieWeb.ConnCase

#   alias Calorie.Cpm

#   @create_attrs %{age: 42, height: 42, weight: 42}
#   @update_attrs %{age: 43, height: 43, weight: 43}
#   @invalid_attrs %{age: nil, height: nil, weight: nil}

#   def fixture(:bmr) do
#     {:ok, bmr} = Cpm.create_physical_profile(@create_attrs)
#     bmr
#   end

#   describe "index" do
#     test "lists all physical_profile", %{conn: conn} do
#       conn = get(conn, Routes.physical_profile_path(conn, :index))
#       assert html_response(conn, 200) =~ "Listing Physical Profile"
#     end
#   end

#   describe "new physical profile" do
#     test "renders form", %{conn: conn} do
#       conn = get(conn, Routes.physical_profile_path(conn, :new))
#       assert html_response(conn, 302) =~ "New Physical Profile"
#     end
#   end

#   describe "create physical profile" do
#     test "redirects to show when data is valid", %{conn: conn} do
#       conn = post(conn, Routes.physical_profile_path(conn, :create), physical_profile: @create_attrs)

#       assert %{id: id} = redirected_params(conn)
#       assert redirected_to(conn) == Routes.physical_profile_path(conn, :show, id)

#       conn = get(conn, Routes.physical_profile_path(conn, :show, id))
#       assert html_response(conn, 200) =~ "Show Physical Profile"
#     end

#     test "renders errors when data is invalid", %{conn: conn} do
#       conn = post(conn, Routes.physical_profile_path(conn, :create), physical_profile: @invalid_attrs)
#       assert html_response(conn, 302) =~ "New Physical Profile"
#     end
#   end

#   describe "edit physical profile" do
#     setup [:create_physical_profile]

#     test "renders form for editing chosen physical profile", %{conn: conn, physical_profile: physical_profile} do
#       conn = get(conn, Routes.physical_profile_path(conn, :edit, physical_profile))
#       assert html_response(conn, 200) =~ "Edit Physical Profile"
#     end
#   end

#   describe "update physical profile" do
#     setup [:create_physical_profile]

#     test "redirects when data is valid", %{conn: conn, physical_profile: physical_profile} do
#       conn = put(conn, Routes.physical_profile_path(conn, :update, physical_profile), physical_profile: @update_attrs)
#       assert redirected_to(conn) == Routes.physical_profile_path(conn, :show, physical_profile)

#       conn = get(conn, Routes.physical_profile_path(conn, :show, physical_profile))
#       assert html_response(conn, 200)
#     end

#     test "renders errors when data is invalid", %{conn: conn, physical_profile: physical_profile} do
#       conn = put(conn, Routes.physical_profile_path(conn, :update, physical_profile), physical_profile: @invalid_attrs)
#       assert html_response(conn, 200) =~ "Edit Physical Profile"
#     end
#   end

#   describe "delete physical profile" do
#     setup [:create_physical_profile]

#     test "deletes chosen physical profile", %{conn: conn, physical_profile: physical_profile} do
#       conn = delete(conn, Routes.physical_profile_path(conn, :delete, physical_profile))
#       assert redirected_to(conn) == Routes.physical_profile_path(conn, :index)
#       assert_error_sent 404, fn ->
#         get(conn, Routes.physical_profile_path(conn, :show, physical_profile))
#       end
#     end
#   end

#   defp create_physical_profile(_) do
#     physical_profile = fixture(:physical_profile)
#     {:ok, physical_profile: physical_profile}
#   end
# end
