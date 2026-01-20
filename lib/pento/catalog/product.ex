defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :unit_price, :float
    field :sku, :integer
    field :user_id, :id
    field :image_upload, :string

    has_many :ratings, Pento.Survey.Rating

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs, user_scope) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:sku, greater_than: 99999)
    |> validate_number(:unit_price, greater_than: 0.0)
    |> unique_constraint(:sku)
    |> put_change(:user_id, user_scope.user.id)
  end

  @doc false
  def markdown_changeset(product, attrs, user_scope) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required([:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
    |> put_change(:user_id, user_scope.user.id)
  end
end
