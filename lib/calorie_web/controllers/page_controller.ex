defmodule CalorieWeb.PageController do
  use CalorieWeb, :controller
  alias Calorie.Accounts
  alias Calorie.Accounts.User
  alias Calorie.Cpm

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
  def index(conn, _params, current_user) do
    #Wyciagnij uzytkownika z bazy
    user = current_user.id
    #Wyciagnij wszystkie pp
    user_pps = Cpm.list_user_pp(current_user)
    #Wyciagnij consumptions
    #Zapodaj

    render(conn, "index.html", user: user, user_pps: user_pps)
  end
end
