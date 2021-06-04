use Mix.Config

# Configure your database
config :calorie, Calorie.Repo,
  username: "postgres",
  password: "coderslab",
  database: "calorie_dev",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calorie, CalorieWeb.Endpoint,
<<<<<<< HEAD
  http: [port: 4002],
=======
  http: [port: 4002],
>>>>>>> f44ed5ba8801157c105bfdc2936f0509e1e0d7ea
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
