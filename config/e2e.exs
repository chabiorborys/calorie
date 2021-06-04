use Mix.Config

import_config "test.exs"

config :calorie, CalorieWeb.Endpoint,
  http: [port: 4002],
  server: true

config :wallaby, driver: Wallaby.Chrome

config :wallaby,
  chromedriver: [
    headless: false
  ]
