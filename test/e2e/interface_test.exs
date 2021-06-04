defmodule E2E.InterfaceTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature

  import Wallaby.Browser
  import Wallaby.Query, only: [text_field: 1, button: 1, css: 2, fill_in]
  alias Wallaby.{Element, Query}


  feature "a user can click button 'Your Cpm'", %{session: session} do
    session
    |> visit("http://localhost:4000/sessions/new")
    |> fill_in(text_field("Username"), with: "test4")
    |> fill_in(text_field("Password"), with: "123Pasword123")
    |> find(Query.button("Log in"), fn el -> Element.click(el) end)
    Process.sleep(1_000)
    session
    |> find(Query.xpath("//*[@class='column']//*[text()='Your Cpm']"), fn el -> Element.click(el) end)

    Process.sleep(4_000)
    assert_text(session, "Listing Physical Profile")

  end

 feature "a user can click 'New Physical Profile", %{session: session} do
  session
  |> visit("http://localhost:4000/sessions/new")
  |> fill_in(text_field("Username"), with: "test4")
  |> fill_in(text_field("Password"), with: "123Pasword123")
  |> find(Query.button("Log in"), fn el -> Element.click(el) end)
  Process.sleep(1_000)
  session
  |> find(Query.xpath("//*[@class='column']//*[text()='Your Cpm']"), fn el -> Element.click(el) end)
  Process.sleep(1_000)
  session
  |> find(Query.xpath("//*[@href='/manage/pp/new']"), fn el -> Element.click(el) end)

  Process.sleep(4_000)
  assert_text(session, "New Physical Profile")
 end

end
