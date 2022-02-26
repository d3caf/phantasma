defmodule Phantasma.Repo do
  use Ecto.Repo,
    otp_app: :phantasma,
    adapter: Ecto.Adapters.Postgres
end
