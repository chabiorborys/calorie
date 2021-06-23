defmodule CalorieWeb.ConsumptionController do
  use CalorieWeb, :controller

  alias Calorie.Cpm
  alias Calorie.Models.Bmr
  alias Calorie.UserFoods
  alias Calorie.UsersFoods.UserFood

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def info(conn, %{"id" => id}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)
    render(conn, "info.html", pp: pp)
  end

  def new(conn, _params) do
    changeset = UserFoods.change_user_food(%UserFood{})
  end


  def create(conn, %{"user_foods" => user_foods_params}) do
    case UserFoods.create_foods(user_foods_params) do
      {:ok, user_foods} ->
        conn
        |> put_flash(:info, "Food selected")
        |> redirect(to: Routes.page_path(@conn, :index, user_foods))

      {:error, %Ecto.Changeset{}= changeset} ->
        redirect(conn, to: "/")
    end
  end
end
