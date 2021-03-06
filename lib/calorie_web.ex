defmodule CalorieWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use CalorieWeb, :controller
      use CalorieWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: CalorieWeb

      import Ecto.Query, only: [from: 1, from: 2]
      import Plug.Conn
      import CalorieWeb.Gettext
      import CalorieWeb.Auth, only: [authenticate_user: 2] #New import
      alias CalorieWeb.Router.Helpers, as: Routes
      alias Calorie.Repo
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/calorie_web/templates",
        namespace: CalorieWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import CalorieWeb.ErrorHelpers
      import CalorieWeb.Gettext
      alias CalorieWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import CalorieWeb.Auth, only: [authenticate_user: 2] #New import
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import CalorieWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
