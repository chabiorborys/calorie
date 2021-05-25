defmodule CalorieWeb.PageController do
  use CalorieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
