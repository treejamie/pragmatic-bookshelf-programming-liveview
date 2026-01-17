defmodule Pento.Catalog.Search do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :sku, :integer
  end

  def changeset(search, attrs \\ %{}) do
    search
    |> cast(attrs, [:sku])
    |> validate_number(:sku, greater_than: 999_999)
  end
end
