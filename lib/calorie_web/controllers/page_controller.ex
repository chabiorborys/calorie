defmodule CalorieWeb.PageController do
  use CalorieWeb, :controller
  alias Calorie.Accounts
  alias Calorie.Accounts.User
  alias Calorie.Cpm
  alias Calorie.Models.Bmr
  alias Calorie.UsersFoods.UserFood
  alias Calorie.UserFoods
  alias Calorie.Products
  alias Calorie.Products.Food

  plug :load_food when action in [:new, :create, :edit, :update, :index]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, nil) do
    user_cpm = 0
    render(conn, "index.html", user_cpm: user_cpm)
  end

  def index(conn, _params, current_user) do
    #Wyciagnij uzytkownika z bazy
    # user = current_user.id
    # #Wyciagnij wszystkie pp

    case Cpm.list_user_pp(current_user) do

      [] -> redirect(conn, to: "/manage/pp/new")
      [user_pp | _] = user_pps ->

        #Wyciagnij consumptions
        user_bmr = Bmr.bmr_for_user(user_pp)
        user_cpm = Float.floor(Bmr.cpm_for_user(user_pp, user_bmr))
        # foods = Products.list_foods()
        changeset = UserFoods.change_user_food(%UserFood{})
        IO.inspect(changeset, label: Changeset)
        render(conn, "index.html", user_pps: user_pps, user_pp: user_pp, user_bmr: user_bmr, user_cpm: user_cpm, changeset: changeset)


    end
  end

  defp load_food(conn, _) do
    query =
      Food
      |> Food.alphabetical
      |> Food.names_and_ids
    foods = Repo.all query
    assign(conn, :foods, foods)
  end

end
