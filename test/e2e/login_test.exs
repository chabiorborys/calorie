defmodule E2E.LoginTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2]
  alias Wallaby.{Element, Query}


  # feature "a user can register with the system", %{session: session} do
  #   session
  #   |> visit("http://localhost:4000/users/new")
  #   |> fill_in(text_field("Name"), with: "test4")
  #   |> fill_in(text_field("Username"), with: "test4")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> find(Query.text("Create User"), fn el -> Element.click(el) end)

  #  Process.sleep(3_000)
  #  assert_text(session, "Listing Users")

  # end

  # feature "a user can Login with his credentials", %{session: session} do
  #   session
  #   |> visit("http://localhost:4000/sessions/new")
  #   |> fill_in(text_field("Username"), with: "test4")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> find(Query.button("Log in"), fn el -> Element.click(el) end)

  #   Process.sleep(1_000)
  #   assert_text(session, "Welcome to Calories")
  # end

  # feature "a user can Logout using log out button", %{session: session} do
  #   session
  #   |> visit("http://localhost:4000/sessions/new")
  #   |> fill_in(text_field("Username"), with: "test4")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> find(Query.button("Log in"), fn el -> Element.click(el) end)
  #   |> find(Query.text("Log out"), fn el -> Element.click(el) end)

  #   Process.sleep(8_000)
  #   assert_text(session, "Welcome to Calories")
  # end


end
