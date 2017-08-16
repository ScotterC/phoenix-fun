defmodule Hello.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Users.User

  @derive {Poison.Encoder, only: [:email, :first_name, :last_name]}
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
  end
end