ExUnit.start()

#Ecto.Adapters.SQL.Sandbox.mode(Calorie.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:wallaby)
{:ok, _} = Application.ensure_all_started(:calorie)

Application.put_env(:wallaby, :base_url, CalorieWeb.Endpoint.url)
