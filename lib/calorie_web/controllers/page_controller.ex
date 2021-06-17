defmodule CalorieWeb.PageController do
  use CalorieWeb, :controller
  alias Calorie.Accounts
  alias Calorie.Accounts.User
  alias Calorie.Cpm
  alias Calorie.Models.Bmr
  alias Calorie.UsersFoods.UserFood
  alias Calorie.UserFoods
  alias Calorie.Products

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end



  def index(conn, _params, current_user) do
    #Wyciagnij uzytkownika z bazy
    user = current_user.id
    # #Wyciagnij wszystkie pp

    case Cpm.list_user_pp(current_user) do
      [] -> redirect(conn, to: "/manage/pp/new")
      [user_pp | _] = user_pps ->
        #Wyciagnij consumptions
        user_bmr = Bmr.bmr_for_user(user_pp)
        user_cpm = Float.floor(Bmr.cpm_for_user(user_pp, user_bmr))
        # foods = Products.list_foods()
        # changeset = UserFoods.change_user_food(%UserFood{})
        #MASZ ZLE ZROBIONA SELECT JEDZENIA W FORMIE
        render(conn, "index.html", user: user, user_pps: user_pps, user_pp: user_pp, user_bmr: user_bmr, user_cpm: user_cpm)


    end
  end


end
