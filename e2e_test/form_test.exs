defmodule E2E.FormTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2, option: 1]
  alias Wallaby.{Element, Query}

  feature "a user can fill out physical profile form", %{session: session} do
    session
    |> visit("http://localhost:4002/sessions/new")
    |> fill_in(text_field("Username"), with: "test4")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.button("Log in"), fn el -> Element.click(el) end)
    Process.sleep(1_000)
    session
    |> visit("http://localhost:4000/manage/pp/new")
    Process.sleep(1_000)
    session
    |> fill_in(text_field("Weight"), with: "90")
    |> fill_in(text_field("Age"), with: "27")
    |> fill_in(text_field("Height"), with: "190")
    |> click(option("Male"))
    |> click(option("Medium activity, sedentary work, 3-4 workouts a week"))
    |> find(Query.button("Save"), fn el -> Element.click(el) end)


    Process.sleep(1_000)
    assert_text(session, "Show Physical Profile")

  end
end
