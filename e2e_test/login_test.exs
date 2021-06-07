defmodule E2E.LoginTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2]
  alias Wallaby.{Element, Query}

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Calorie.Repo)
  end

  defp random_name() do
    (?A..?Z) |> Enum.shuffle() |> Enum.take(10) |> List.to_string()
  end

  defp random_username() do
    (?A..?Z) |> Enum.take(21) |> List.to_string()
  end

  feature "len('username') > 3, while creating an account", %{session: session} do
    session
    |> visit("http://localhost:4002/users/new")
    |> fill_in(text_field("Name"), with: "test4")
    |> fill_in(text_field("Username"), with: "te")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.text("Create User"), fn el -> Element.click(el) end)

    Process.sleep(1_000)
    assert_text(session, "should be at least 3 character(s)")
  end

  feature "len('username') < 20, while creating an account", %{session: session} do
    new_username = random_username()
    session
    |> visit("http://localhost:4002/users/new")
    |> fill_in(text_field("Name"), with: "test4")
    |> fill_in(text_field("Username"), with: new_username)
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.text("Create User"), fn el -> Element.click(el) end)

    Process.sleep(1_000)
    assert_text(session, "should be at most 20 character(s)")


  end


  # test "a user can register with the system" do
  #   new_name = random_name()
  #   {:ok, session} = Wallaby.start_session()
  #   session
  #   |> visit("http://localhost:4002/users/new")
  #   |> fill_in(text_field("Name"), with: "test4")
  #   |> fill_in(text_field("Username"), with: "test4")
  #   |> fill_in(text_field("Password"), with: "123Pasword123")
  #   |> find(Query.text("Create User"), fn el -> Element.click(el) end)

  #   Process.sleep(1_000)
  #   assert_text(session, "Listing Users")
  # end

  feature "a user can Login with his credentials", %{session: session} do
    session
    |> visit("http://localhost:4002/sessions/new")
    |> fill_in(text_field("Username"), with: "test4")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.button("Log in"), fn el -> Element.click(el) end)

    Process.sleep(1_000)
    assert_text(session, "Welcome to Calories")
  end

  feature "a user can Logout using log out button", %{session: session} do
    session
    |> visit("http://localhost:4002/sessions/new")
    |> fill_in(text_field("Username"), with: "test4")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.button("Log in"), fn el -> Element.click(el) end)
    |> find(Query.text("Log out"), fn el -> Element.click(el) end)

    Process.sleep(1_000)
    assert_text(session, "Welcome to Calories")
  end



end
