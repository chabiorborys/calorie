defmodule CalorieWeb.ConsumptionController do
  use CalorieWeb, :controller

  alias Calorie.Cpm
  alias Calorie.Models.Bmr

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def info(conn, %{"id" => id}, current_user) do
    pp = Cpm.get_user_pp!(current_user, id)
    render(conn, "info.html", pp: pp)
  end
end
