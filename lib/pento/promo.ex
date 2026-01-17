defmodule Pento.Promo do
  @moduledoc """
  Context for promotions.
  """
  alias Pento.Promo.Recipient
  alias Pento.Accounts.RecipientNotifier

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
    changeset =
      recipient
      |> change_recipient(attrs)
      |> Ecto.Changeset.apply_action(:update)

    with {:ok, recipient} <- changeset do
      RecipientNotifier.deliver_promo_code(recipient)
      {:ok, recipient}
    else
      error ->
        IO.inspect(error, label: "error")
        IO.inspect("nope")
        error
    end
  end
end
