defmodule Pento.Promo do
  @moduledoc """
  Context for promotions.
  """
  alias Pento.Promo.Recipient

  @doc """
  Changes the recipient in a changeset.
  """
  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  @doc """
  # TODO: Sends a promotional email
  """
  def send_promo(recipient, attrs) do
    recipient
    |> change_recipient(attrs)
    |> Ecto.Changeset.apply_action(:update)
  end
end
