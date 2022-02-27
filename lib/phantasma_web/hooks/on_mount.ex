defmodule PhantasmaWeb.Hooks.OnMount do
  import Phoenix.LiveView
  require Logger

  def on_mount(:default, _params, %{"reddit_access_token" => token} = session, socket) when not is_nil(token) do

    IO.inspect session
    {:cont, socket |> assign_new(:reddit, fn -> Breddit.client(token: token) end)}
  end

  def on_mount(:default, params, _session, socket) do
    IO.inspect params
    Logger.error("Not authorized with reddit so can't create a client.")
    {:cont, socket}
  end
end
