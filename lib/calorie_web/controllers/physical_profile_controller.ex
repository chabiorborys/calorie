defmodule CalorieWeb.PhysicalProfileController do
  use CalorieWeb, :controller

  alias Calorie.Cpm
  alias Calorie.Cpm.PhysicalProfile
  alias Calorie.Products
  alias Calorie.Models.Bmr

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    pps = Cpm.list_user_pp(current_user)
    render(conn, "index.html", pps: pps)
  end

  def new(conn, _params, _current_user) do
    changeset = Cpm.change_pp(%PhysicalProfile{})
    render(conn, "new.html", changeset: changeset, activity_choices: activity_list())
  end

  defp activity_list do
    [
      "Inactivity, sedentary work": "1",
      "Low activity, sedentary work, 1-2 workouts a week": "2",
      "Medium activity, sedentary work, 3-4 workouts a week": "3",
      "High activity, physical work, 3-4 workouts a week": "4",
      "Very high activity, professional athletes, people training every day": "5"
    ]
  end

  def create(conn, %{"physical_profile" => pp_params}, current_user) do
    case Cpm.create_pp(current_user, pp_params) do
      {:ok, pp} ->
        conn
        |> put_flash(:info, "Physical Profile created successfully.")
        |> redirect(to: Routes.physical_profile_path(conn, :show, pp))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    #Retrviving users bmr inforamtions
    pp = Cpm.get_user_pp!(current_user, id)
    #Calculating users bmr
    user_bmr = Bmr.bmr_for_user(pp)
    #Calculating users cpm
    user_cpm = Bmr.cpm_for_user(pp, user_bmr)

    #Retriving products
    products = Products.list_foods


    render(conn, "show.html", pp: pp, user_bmr: user_bmr, user_cpm: user_cpm, products: products)
  end

  def edit(conn, %{"id" => id}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)
    changeset = Cpm.change_pp(pp)
    render(conn, "edit.html", pp: pp, changeset: changeset, activity_choices: activity_list())
  end

  def update(conn, %{"id" => id, "pp" => pp_params}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)

    case Cpm.update_pp(pp, pp_params) do
      {:ok, pp} ->
        conn
        |> put_flash(:info, "Physical Profile updated successfully.")
        |> redirect(to: Routes.physical_profile_path(conn, :show, pp))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pp: pp, changeset: changeset, activity_choices: activity_list())
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)
    {:ok, _pp} = Cpm.delete_pp(pp)

    conn
    |> put_flash(:info, "Physical Profile deleted successfully.")
    |> redirect(to: Routes.physical_profile_path(conn, :index))
  end
end
