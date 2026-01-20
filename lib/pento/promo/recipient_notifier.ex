defmodule Pento.Accounts.RecipientNotifier do
  import Swoosh.Email

  alias Pento.Mailer

  # Delivers the email using the application mailer.
  defp deliver(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"Pento", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- Mailer.deliver(email) do
      {:ok, email}
    end
  end

  @doc """
  Deliver instructions to update a user email.
  """
  def deliver_promo_code(recipient) do
    deliver(recipient.email, "Redeem your promo", """

    ==============================

    Hi #{recipient.first_name},

    You've been gifted a promo code.

    Good times.


    If you didn't request this change, please ignore this.

    ==============================
    """)
  end
end
