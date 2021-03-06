defmodule DropAlley.Auth.AuthAccessPipeline do
  @moduledoc false
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline, otp_app: :drop_alley

  plug(Guardian.Plug.VerifySession, claims: @claims)
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
  # plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource)
end