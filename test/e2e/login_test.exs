defmodule E2E.LoginTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2]
  alias Wallaby.{Element, Query}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Calorie.Repo)
  end

  test "a user can register with the system" do
    {:ok, session} = Wallaby.start_session()
    session
    |> visit("http://localhost:4000/users/new")
    |> fill_in(text_field("Name"), with: "test2")
    |> fill_in(text_field("Username"), with: "test2")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.text("Create User"), fn el -> Element.click(el) end)


   Process.sleep(20_000)
   assert_text(session, "Listing Users")

  end

  # test "a user can login with his credentials" do
  #   {:ok, session} = Wallaby.start_session()
  #   session
  #   |> visit("http://localhost:4000/sessions/new")
  #   |> fill_in(text_field("Username"), with: "test1")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> click(button("Log in"))
  #   Process.sleep(20_000)
  # end



end
