use Mix.Config

# Configure your database
config :calorie, Calorie.Repo,
  username: "postgres",
  password: "coderslab",
  database: "calorie_dev",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calorie, CalorieWeb.Endpoint,
  http: [port: 4000],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :wallaby, driver: Wallaby.Chrome

config :wallaby,
  chromedriver: [
    headless: false
  ]
