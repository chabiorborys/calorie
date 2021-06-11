defmodule CalorieWeb.PageController do
  use CalorieWeb, :controller
  alias Calorie.Accounts
  alias Calorie.Accounts.User
  alias Calorie.Cpm
  alias Calorie.Models.Bmr

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
  def index(conn, _params, current_user) do
    #Wyciagnij uzytkownika z bazy
    user = current_user.id
    # #Wyciagnij wszystkie pp
    user_pps = Cpm.list_user_pp(current_user)
    user_pp = Cpm.get_user_pp!(current_user, user)
    #Wyciagnij consumptions
    user_bmr = Bmr.bmr_for_user(user_pp)
    user_cpm = Float.floor(Bmr.cpm_for_user(user_pp, user_bmr))

    #Zapodaj

    render(conn, "index.html", user: user, userp_pps: user_pps, user_cpm: user_cpm)
  end
end
