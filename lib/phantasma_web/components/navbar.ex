defmodule PhantasmaWeb.Components.Navbar do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def render(%{} = assigns) do
    ~H"""
    <nav class="navbar" role="navigation" aria-label="main navigation">
      <div class="navbar-brand">
        <a class="navbar-item" href="/">
          <span class="is-size-3-desktop" style="font-family: Calistoga">Phantasma</span>
        </a>

        <button class="navbar-burger" aria-label="menu" phx-click={JS.toggle(to: ".navbar-menu", in: "is-active")}>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </button>
      </div>

      <div id="navbarBasicExample" class="navbar-menu">
        <div class="navbar-start">
          <!--
          <a class="navbar-item">
            Home
          </a>

          <a class="navbar-item">
            Documentation
          </a>

          <div class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              More
            </a>

            <div class="navbar-dropdown">
              <a class="navbar-item">
                About
              </a>
              <a class="navbar-item">
                Jobs
              </a>
              <a class="navbar-item">
                Contact
              </a>
              <hr class="navbar-divider">
              <a class="navbar-item">
                Report an issue
              </a>
            </div>
          </div>
          -->
        </div>

        <div class="navbar-end">
          <div class="navbar-item">
            <div class="buttons">
              <.login user={@user} />
            </div>
          </div>
        </div>
      </div>
    </nav>
    """
  end

  defp login(%{user: nil} = assigns) do
    ~H"""
    <a class="button is-primary" href={PhantasmaWeb.Router.Helpers.auth_path(PhantasmaWeb.Endpoint, :index)}>
      <span class="icon">
        <ion-icon class="icon" name="logo-reddit" />
      </span>
      <span>
        Sign in with Reddit
      </span>
    </a>
    """
  end

  defp login(%{user: user} = assigns) do
    ~H"""
    <a class="button is-primary is-light" href={PhantasmaWeb.Router.Helpers.auth_path(PhantasmaWeb.Endpoint, :delete)}>
      <span class="icon">
        <ion-icon class="icon" name="logo-reddit" />
      </span>
      <span>
        Sign out <%= username(@user) %>
      </span>
    </a>
    """
  end

  defp username(%{name: name}), do: name
  defp username(_), do: ""
end
