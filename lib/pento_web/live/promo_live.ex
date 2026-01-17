defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_recipient() |> clear_form()}
  end

  def handle_event(
        "save",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    {:noreply,
     case Promo.send_promo(recipient, recipient_params) do
       {:ok, _changeset} ->
         socket
         |> put_flash(:info, "sent it")
         |> push_navigate(to: ~p"/")

       {:error, changeset} ->
         socket
         |> put_flash(:error, "could not send it")
         |> assign_form(changeset)
     end}
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  # should these be defp?
  def assign_recipient(socket) do
    socket |> assign(:recipient, %Recipient{})
  end

  def clear_form(socket) do
    changeset =
      socket.assigns.recipient
      |> Promo.change_recipient()

    socket |> assign_form(changeset)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
