defmodule PhantasmaWeb.Hooks.OnMount do
  import Phoenix.LiveView
  require Logger

  def on_mount(:default, _params, %{"reddit_access_token" => token}, socket) do
    {:cont, socket |> assign_new(:reddex, fn -> Reddex.client(token: token) end)}
  end

  def on_mount(:default, _params, _session, socket) do
    Logger.error("Not authorized with reddit so can't create a client.")
    {:cont, socket}
  end
end
