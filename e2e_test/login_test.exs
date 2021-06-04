defmodule E2E.LoginTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2]
  alias Wallaby.{Element, Query}

<<<<<<< HEAD:test/e2e/login_test.exs

  # feature "a user can register with the system", %{session: session} do
  #   session
  #   |> visit("http://localhost:4000/users/new")
  #   |> fill_in(text_field("Name"), with: "test4")
  #   |> fill_in(text_field("Username"), with: "test4")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> find(Query.text("Create User"), fn el -> Element.click(el) end)

  #  Process.sleep(3_000)
  #  assert_text(session, "Listing Users")
=======
  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Calorie.Repo)
  end

  defp random_name() do
    (?A..?Z) |> Enum.shuffle() |> Enum.take(10) |> List.to_string()
  end

  test "a user can register with the system" do
    new_name = random_name()
    {:ok, session} = Wallaby.start_session()
    session
    |> visit("http://localhost:4002/users/new")
    |> fill_in(text_field("Name"), with: new_name)
    |> fill_in(text_field("Username"), with: new_name)
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.text("Create User"), fn el -> Element.click(el) end)

   assert_text(session, "Listing Users")
>>>>>>> f44ed5ba8801157c105bfdc2936f0509e1e0d7ea:e2e_test/login_test.exs

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
