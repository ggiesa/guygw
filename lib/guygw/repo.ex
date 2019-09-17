defmodule Guygw.Repo do
  use Ecto.Repo,
    otp_app: :guygw,
    adapter: Ecto.Adapters.Postgres
end
