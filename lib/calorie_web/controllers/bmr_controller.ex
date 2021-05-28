defmodule CalorieWeb.BmrController do
  use CalorieWeb, :controller

  alias Calorie.Cpm
  alias Calorie.Cpm.Bmr
  alias Calorie.Products

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    bmrs = Cpm.list_user_bmr(current_user)
    render(conn, "index.html", bmrs: bmrs)
  end

  def new(conn, _params, _current_user) do
    changeset = Cpm.change_bmr(%Bmr{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bmr" => bmr_params}, current_user) do
    case Cpm.create_bmr(current_user, bmr_params) do
      {:ok, bmr} ->
        conn
        |> put_flash(:info, "Bmr created successfully.")
        |> redirect(to: Routes.bmr_path(conn, :show, bmr))
        IO.inspect(conn)

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    #Retrviving users bmr inforamtions
    bmr = Cpm.get_user_bmr!(current_user, id)
    #Calculating users bmr
    user_bmr =
      case bmr.sex do
        "Female" -> (9.99 * bmr.weight + 6.25 * bmr.height - 4.92 * bmr.age) - 161
        "Male" -> (9.99 * bmr.weight + 6.25 * bmr.height - 4.92 * bmr.age) + 5
      end
    #Calculating users cpm
    user_cpm =
      case bmr.physical_activity do
        "Inactivity, sedentary work" -> user_bmr * 1.2
        "Low activity, sedentary work, 1-2 workouts a week" -> user_bmr * 1.3
        "Medium activity, sedentary work, 3-4 workouts a week" -> user_bmr * 1.5
        "High activity, physical work, 3-4 workouts a week" -> user_bmr * 1.7
        "Very high activity, professional athletes, people training every day" -> user_bmr * 1.9
      end
    #Retriving products
    products = Products.list_foods


    render(conn, "show.html", bmr: bmr, user_bmr: user_bmr, user_cpm: user_cpm, products: products)
  end

  def edit(conn, %{"id" => id}, current_user) do
    bmr = Cpm.get_user_bmr!(current_user, id)
    changeset = Cpm.change_bmr(bmr)
    render(conn, "edit.html", bmr: bmr, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bmr" => bmr_params}, current_user) do
    bmr = Cpm.get_user_bmr!(current_user, id)

    case Cpm.update_bmr(bmr, bmr_params) do
      {:ok, bmr} ->
        conn
        |> put_flash(:info, "Bmr updated successfully.")
        |> redirect(to: Routes.bmr_path(conn, :show, bmr))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bmr: bmr, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    bmr = Cpm.get_user_bmr!(current_user, id)
    {:ok, _bmr} = Cpm.delete_bmr(bmr)

    conn
    |> put_flash(:info, "Bmr deleted successfully.")
    |> redirect(to: Routes.bmr_path(conn, :index))
  end
end
