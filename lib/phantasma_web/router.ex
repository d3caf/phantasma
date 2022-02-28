defmodule PhantasmaWeb.Router do
  use PhantasmaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhantasmaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug :auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhantasmaWeb do
    pipe_through :browser
    get "/cb", AuthController, :callback

    get "/", PageController, :index

  end

  scope "/app", PhantasmaWeb do
    pipe_through [:browser, :authenticated]

    live_session :default, on_mount: PhantasmaWeb.Hooks.OnMount do
      # Posts
      live "/posts", PostLive.Index, :index
      live "/posts/new", PostLive.Index, :new
      live "/posts/:id/edit", PostLive.Index, :edit

      live "/posts/:id", PostLive.Show, :show
      live "/posts/:id/show/edit", PostLive.Show, :edit

      # Links
      live "/links", LinkLive.Index, :index
      live "/links/new", LinkLive.Index, :new
      live "/links/:id/edit", LinkLive.Index, :edit

      live "/links/:id", LinkLive.Show, :show
      live "/links/:id/show/edit", LinkLive.Show, :edit

      # Submissions
      live "/submissions", SubmissionLive.Index, :index
      live "/submissions/new", SubmissionLive.Index, :new
      live "/submissions/:id/edit", SubmissionLive.Index, :edit

      live "/submissions/:id", SubmissionLive.Show, :show
      live "/submissions/:id/show/edit", SubmissionLive.Show, :edit
    end

  end

  scope "/auth", PhantasmaWeb do
    pipe_through :browser

    get "/", AuthController, :index
    get "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhantasmaWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PhantasmaWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  def auth(%{request_path: return_to, query_params: query} = conn, _opts) do
    redirect = "/?#{query |> Map.put("return_to", return_to) |> URI.encode_query()}"

    if get_session(conn, :reddit_access_token) do
      conn
    else
      conn
      |> put_flash(:error, "You need to authorize with reddit first!")
      |> redirect(to: redirect)
    end
  end
end
