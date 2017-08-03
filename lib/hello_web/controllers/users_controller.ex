defmodule HelloWeb.UsersController do
  use HelloWeb, :controller
  alias Hello.Repo
  alias Hello.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.json", users: users
  end

  def show(conn, _params) do
    user = %{email: "foo"}

    render conn, "show.json", page: user
  end
end