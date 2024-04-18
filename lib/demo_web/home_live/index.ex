defmodule DemoWeb.HomeLive.Index do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, number: 10)
    {:ok, socket}
  end
end
