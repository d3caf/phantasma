defmodule PhantasmaWeb.AuthController do
  use PhantasmaWeb, :controller
  alias PhantasmaWeb.Router.Helpers

  @doc """
  This action is reached via `/auth/:provider` and redirects to the OAuth2 provider
  based on the chosen strategy.
  """
  def index(conn, _params) do
    redirect conn, external: authorize_url!("reddit")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> delete_session(:reddit_access_token)
    |> redirect(to: "/")
  end

  @doc """
  This action is reached via `/auth/cb` is the the callback URL that
  the OAuth2 provider will redirect the user back to with a `code` that will
  be used to request an access token. The access token will then be used to
  access protected resources on behalf of the user.
  """
  def callback(conn, %{"code" => code}) do
    # Exchange an auth code for an access token
    client = get_token!("reddit", code)

    # Request the user's data with the access token
    user = get_user!("reddit", client)

    # Store the user in the session under `:current_user` and redirect to /.
    # In most cases, we'd probably just store the user's ID that can be used
    # to fetch from the database. In this case, since this example app has no
    # database, I'm just storing the user map.
    #
    # If you need to make additional resource requests, you may want to store
    # the access token as well.
    conn
    |> put_session(:reddit_current_user, user)
    |> put_session(:reddit_access_token, client.token.access_token)
    |> assign(:reddex_client, client)
    |> redirect(to: "/manage/posts")
  end

  defp authorize_url!("reddit"), do: Reddex.authorize_url!()
  defp get_token!("reddit", code), do: Reddex.get_token!(code: code)
  defp get_user!("reddit", client) do
    %{body: user} = OAuth2.Client.get!(client, "api/v1/me")
    %{name: user["name"]}
  end

end
