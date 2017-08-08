defmodule HelloWeb.UserView do
  use HelloWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, HelloWeb.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, HelloWeb.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end

  def render("not_found.json", %{user: nil}) do
    %{message: "Not Found"}
  end

  def render("not_acceptable.json", %{user: nil}) do
    %{message: "Not Acceptable"}
  end
end