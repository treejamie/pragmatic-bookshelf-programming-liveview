defmodule Pento.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Catalog.Product
  alias Pento.Accounts.User

  schema "ratings" do
    field :stars, :integer

    belongs_to :user, User
    belongs_to :product, Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rating, attrs, user_scope) do
    rating
    |> cast(attrs, [:stars, :product_id])
    |> validate_required([:stars, :user_id, :product_id])
    |> validate_inclusion(:stars, 1..5)
    |> put_change(:user_id, user_scope.user.id)
    |> unique_constraint([:user_id, :product_id])
  end
end
