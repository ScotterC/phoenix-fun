require IEx
defmodule HelloWeb.UserControllerTest do
  use HelloWeb.ConnCase

  alias Hello.Users

  @create_attrs %{email: "some email", first_name: "some first name", last_name: "some last name"}
  @update_attrs %{email: "some updated email", first_name: "some updated first name", last_name: "some updated last name"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil}


  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      user = fixture(:user)
      conn = get conn, user_path(conn, :index)
      body = json_response(conn, 200)

      # TODO: Don't love this
      # assert Users.fields(user) in body["data"]
      assert user.email == List.first(body["data"])["email"]
    end
  end

  # describe "create user" do

  # end

  # describe "update user" do

  # end

  # describe "delete user" do

  # end

  # test "index/2 responses with all Users" do
  #   users =  [ User.changeset(%User{}, @valid_attrs),
  #              User.changeset(%User{}, @valid_attrs) ]

  #   Enum.each(users, &Repo.insert!(&1))

  #   response = build_conn()
  #   |> get(user_path(build_conn(), :index))
  #   |> json_response(200)

  #   expected = %{
  #     "data" => [
  #       %{"email" => "foo@bar.com", "first_name" => "Foo", "last_name" => "Bar"},
  #       %{"email" => "foo@bar.com", "first_name" => "Foo", "last_name" => "Bar"}
  #     ]
  #   }

  #   assert response == expected

  #   # assert %{"id" => _, "email" => "foo@bar.com", "first_name" => "Foo", "last_name" => "Bar"} == List.first(response["data"])
  # end

  # describe "show/2" do
  #   test "responds with user when found"
  #   test "responds with 404 when user not found"
  # end

  # describe "create/2" do
  #   test "creates and responds with newly created users if attributes are valid"
  #   test "returns a 406 not acceptable when attributes are not valid"
  # end

  # test "delete/2 responds with 204 if user was deleted"

end