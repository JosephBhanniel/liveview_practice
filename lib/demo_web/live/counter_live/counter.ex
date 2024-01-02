defmodule DemoWeb.CounterLive.Counter do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
  socket =
   socket
   |> assign(:counter, 0)
   {:ok, socket}
end


  def render(assigns) do
    ~H"""


    <h1 class= "text-center text-bold md:text-3xl text-1xlmy-3 "> Exercise # 2 events</h1>
    <div class="p-5 class text-center">
    <h2 class= "text-center text-bold text-xl"> The counter </h2>
    <h1><%= @counter %></h1>
    <div class="d-flex justify-content-around">
    <.button phx-click="increment"> + </.button>
    <.button phx-click="decrement"> - </.button>
    </div>

    </div>

    """
  end

  def handle_event("increment", _value, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def handle_event("decrement", _value, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter - 1)}
  end
end
