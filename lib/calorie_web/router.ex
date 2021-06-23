defmodule CalorieWeb.Router do
  use CalorieWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CalorieWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CalorieWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/create", ConsumptionController, :create
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/foods", FoodController
  end

  scope "/manage", CalorieWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/pp", PhysicalProfileController
    # get "/consumption/:id", ConsumptionController, :info
  end

  # Other scopes may use custom stacks.
  # scope "/api", CalorieWeb do
  #   pipe_through :api
  # end
end
