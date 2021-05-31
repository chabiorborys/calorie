defmodule E2E.LoginTest do
  use ExUnit.Case, async: false

  import Wallaby.Browser
  alias Wallaby.{Element, Query}


  test "a user can register with the system" do
    {:ok, session} = Wallaby.start_session()
    session
    |> visit("http://localhost:4000/")
    |> find(Query.text("Register"), fn el -> Element.click(el) end)

    assert_text(session, "New User")

  end



end
