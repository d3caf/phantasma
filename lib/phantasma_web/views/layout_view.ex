defmodule PhantasmaWeb.LayoutView do
  use PhantasmaWeb, :view
  import Plug.Conn, only: [get_session: 2, get_session: 1]

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}
end
