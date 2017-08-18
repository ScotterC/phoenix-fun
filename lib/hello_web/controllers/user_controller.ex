defmodule HelloWeb.UserController do
  use HelloWeb, :controller

  alias Hello.Users

  def index(conn, _params) do
    users = Users.list_users()
    render conn, "index.json", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render conn, "show.json", user: user

    # if user do
    #   render conn, "show.json", user: user
    # else
    #   send_resp(conn, 404, "")
    # end
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_status(201)
        |> render("show.json", user: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(406)
        |> render("not_acceptable.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)
    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_status(200)
        |> render("show.json", user: user)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(406)
        |> render("not_acceptable.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)
    send_resp(conn, 204, "")
  end
end