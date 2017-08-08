require IEx;

defmodule HelloWeb.UserController do
  use HelloWeb, :controller
  alias Hello.Repo
  alias Hello.User

  def index(conn, _params) do
    users = Repo.all(User)
    render conn, "index.json", users: users
  end

  def show(conn, params) do
    user = Repo.get(User, params["id"])

    if user do
      render conn, "show.json", user: user
    else
      render conn, "not_found.json", user: nil
    end
  end

  def create(conn, params) do
    user = %User{email: params["email"],
                 first_name: params["first_name"],
                 last_name: params["last_name"]
                }
    changeset = User.changeset(user, %{})

    if changeset.valid? do
      {:ok, user } = Repo.insert(user)
      user = Repo.get(User, user.id)
      conn
      |> put_status(201)
      |> render "show.json", user: user
    else
      conn
      |> put_status(406)
      |> render "not_acceptable.json", user: nil
    end
  end

  def update(conn, params) do

  end

  def delete(conn, params) do
    user = Repo.get(User, params["id"])
    Repo.delete user
    conn
    |> put_status(204)
    |> render "show.json", user: user
  end
end