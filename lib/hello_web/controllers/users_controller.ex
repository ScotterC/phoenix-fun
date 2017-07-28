defmodule HelloWeb.UsersController do
  use HelloWeb, :controller

  def index(conn, _params) do
    users = []
    json conn, users
  end

  def show(conn, %{"id" => id}) do
    render conn, :show, id: id
  end
end