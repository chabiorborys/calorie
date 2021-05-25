defmodule CalorieWeb.UserView do
  use CalorieWeb, :view
  alias Calorie.Accounts

  def first_name(%Accounts.User{name: name}) do
     name
     |> String.split(" ")
     |> Enum.at(0)
  end


end
