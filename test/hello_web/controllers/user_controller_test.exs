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

  describe "show" do
    setup [:create_user]

    test "responds with user if it exists", %{conn: conn, user: user} do
      conn = get conn, user_path(conn, :show, user), id: user.id

      body = json_response(conn, 200)
      assert @create_attrs.email, body["data"]["email"]
    end

  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @create_attrs

      body = json_response(conn, 201)
      assert @create_attrs.email, body["data"]["email"]
    end

    test "responds with error when data is invalid", %{conn: conn} do
      conn = post conn, user_path(conn, :create), user: @invalid_attrs

      body = json_response(conn, 406)

      assert body["message"] =~ "Not Acceptable"
      assert body["errors"]["last_name"] == ["can't be blank"]
    end
  end

  describe "update user" do
    setup [:create_user]

    test "responds 200 when data is valid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @update_attrs

      body = json_response(conn, 200)

      assert @update_attrs.email, body["data"]["email"]
    end

    test "responds with errors when data is invalid", %{conn: conn, user: user} do
      conn = put conn, user_path(conn, :update, user), user: @invalid_attrs

      body = json_response(conn, 406)

      assert body["message"] =~ "Not Acceptable"
      assert body["errors"]["last_name"] == ["can't be blank"]
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete conn, user_path(conn, :delete, user)
      response(conn, 204)

      # Show action
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, user)
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end