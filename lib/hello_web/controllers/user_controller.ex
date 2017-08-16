defmodule HelloWeb.UserController do
  use HelloWeb, :controller

  alias Hello.Users
  alias Hello.Users.User

  def index(conn, _params) do
    users = Users.list_users()
    render conn, "index.json", users: users
  end

  def show(conn, params) do
    user = Users.get_user!(params["id"])

    if user do
      render conn, "show.json", user: user
    else
      render conn, "not_found.json", user: nil
    end
  end

  def create(conn, params) do
    user = %User{
                 email: params["email"],
                 first_name: params["first_name"],
                 last_name: params["last_name"]
                }
    changeset = User.changeset(user, %{})

    if changeset.valid? do
      Users.create_user(params)
      user = Users.get_user!(user.id)
      conn
      |> put_status(201)
      |> render("show.json", user: user)
    else
      conn
      |> put_status(406)
      |> render("not_acceptable.json", user: nil)
    end
  end

  # def update(conn, params) do

  # end

  def delete(conn, params) do
    user = Users.get_user!(params["id"])
    {:ok, _user} = Users.delete_user(user)
    conn
    |> put_status(204)
    |> render("show.json", user: user)
  end
end