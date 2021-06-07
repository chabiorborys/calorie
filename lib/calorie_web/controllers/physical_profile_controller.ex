defmodule CalorieWeb.PhysicalProfileController do
  use CalorieWeb, :controller

  alias Calorie.Cpm
  alias Calorie.Cpm.PhysicalProfile
  alias Calorie.Products

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
    render(conn, "new.html", changeset: changeset)
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
    user_bmr =
      case pp.sex do
        "Female" -> (9.99 * pp.weight + 6.25 * pp.height - 4.92 * pp.age) - 161
        "Male" -> (9.99 * pp.weight + 6.25 * pp.height - 4.92 * pp.age) + 5
      end

    #Calculating users cpm
    user_cpm =
      case pp.physical_activity do
        "Inactivity, sedentary work" -> user_bmr * 1.2
        "Low activity, sedentary work, 1-2 workouts a week" -> user_bmr * 1.3
        "Medium activity, sedentary work, 3-4 workouts a week" -> user_bmr * 1.5
        "High activity, physical work, 3-4 workouts a week" -> user_bmr * 1.7
        "Very high activity, professional athletes, people training every day" -> user_bmr * 1.9
      end


    #Retriving products
    products = Products.list_foods


    render(conn, "show.html", pp: pp, user_bmr: user_bmr, user_cpm: user_cpm, products: products)
  end

  def edit(conn, %{"id" => id}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)
    changeset = Cpm.change_pp(pp)
    render(conn, "edit.html", pp: pp, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pp" => pp_params}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)

    case Cpm.update_pp(pp, pp_params) do
      {:ok, pp} ->
        conn
        |> put_flash(:info, "Physical Profile updated successfully.")
        |> redirect(to: Routes.physical_profile_path(conn, :show, pp))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pp: pp, changeset: changeset)
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
