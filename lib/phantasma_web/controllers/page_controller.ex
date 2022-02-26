defmodule PhantasmaWeb.PageController do
  use PhantasmaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
