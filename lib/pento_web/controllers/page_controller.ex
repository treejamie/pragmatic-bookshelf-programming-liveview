defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def home(conn, _params) do
    if conn.assigns.current_scope && conn.assigns.current_scope.user do
      conn
      |> redirect(to: ~p"/guess")
      |> halt()
    else
      render(conn, :home)
    end
  end
end
