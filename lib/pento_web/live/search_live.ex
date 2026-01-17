defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Catalog.Search

  def render(assigns) do
    ~H"""
    <div class="m-8">
      <.form
        for={@form}
        id="promo-form"
        phx-change="validate"
        phx-submit="search"
      >
        <.input field={@form[:sku]} type="number" label="search" />
        <.button phx-disable-with="Searching...">search</.button>
      </.form>
    </div>
    """
  end

  def handle_event("search", %{"search" => search_params}, socket) do
    IO.inspect("do some things with #{search_params}")
    {:noreply, socket}
  end

  def handle_event("validate", %{"search" => search_params}, socket) do
    changeset =
      socket.assigns.search
      |> Search.changeset(search_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_search() |> clear_form()}
  end

  def clear_form(socket) do
    changeset =
      socket.assigns.search
      |> Search.changeset()

    socket |> assign_form(changeset)
  end

  def assign_search(socket) do
    assign(socket, :search, %Search{})
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
