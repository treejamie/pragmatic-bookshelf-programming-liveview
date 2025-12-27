defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = reset(socket)

    {:ok, socket}
  end

  defp reset(socket) do
    socket
    |> assign(score: 10)
    |> assign(state: :play)
    |> assign(message: "Make a guess...")
    |> assign(answer: Enum.random(1..10) |> Integer.to_string())
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    socket =
      if guess == socket.assigns[:answer] do
        socket
        |> assign(state: :won)
      else
        socket
        |> assign(message: "Your guess: #{guess}. Wrong. Guess again")
        |> assign(score: socket.assigns.score - 1)
      end

    {:noreply, socket}
  end

  def handle_event("restart", _params, socket) do
    {:noreply, reset(socket)}
  end

  def render(assigns) do
    ~H"""
    <main class="px-4 py-20 sm:px-6 lg:px-8">
      <%= if @state == :play  do %>
        {play(assigns)}
      <% else %>
        {won(assigns)}
      <% end %>
    </main>
    """
  end

  defp won(assigns) do
    ~H"""
    <h2 class="mb-4 text-4xl font-extrabold">You Win</h2>
    <p>
      You correctly guessed the answer was {@answer} and your final
      score was {@score}.
    </p>
    <p>
      <.link class="btn btn-secondary" phx-click="restart"> play again </.link>
    </p>
    """
  end

  defp play(assigns) do
    ~H"""
    <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
    <p>
      {@message}
    </p>
    <p>
      It's {time()}
    </p>
    <br />
    <h2>
      <%= for n <- 1..10 do %>
        <.link
          class="btn btn-secondary"
          phx-click="guess"
          phx-value-number={n}
        >
          {n}
        </.link>
      <% end %>
    </h2>
    """
  end

  def time do
    DateTime.utc_now() |> to_string()
  end
end
