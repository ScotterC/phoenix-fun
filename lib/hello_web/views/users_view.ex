defmodule HelloWeb.UsersView do
  use HelloWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, HelloWeb.UsersView, "user.json")}
  end

  def render("user.json", %{users: users}) do
    %{id: users.id, email: users.email}
  end

  # def render("show.json", %{user: user}) do
  #   %{data: render_one(user, HelloWeb.UsersView, "user.json")}
  # end

  # def user_json(user) do
  #   %{
  #     email: user.title
  #   }
  # end
end