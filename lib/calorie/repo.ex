defmodule Calorie.Repo do
  use Ecto.Repo,
    otp_app: :calorie,
    adapter: Ecto.Adapters.Postgres
end
