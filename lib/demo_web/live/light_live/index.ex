defmodule DemoWeb.LightLive.Index do
   use DemoWeb, :live_view


   def mount(_params, _session, socket) do

       if connected?(socket) do
         :timer.send_interval(1000, self(), :tick)
       end

     socket =
      socket
      |> assign(:light_bulb_status, "off")
      |> assign(:counter, 0)
      |> assign_current_time()
      {:ok, socket}
   end

   def render(assigns) do

    ~H"""
      <h1 class= "text-center text-bold md:text-3xl text-1xl"> =========== Exercise # 1 Events ========== </h1>
      <div class="text-center">
      <h2 class= "text-center text-bold text-xl"> The Light Exercise </h2>
      <p class="p-3 my-2">The light is <%= @light_bulb_status %> </p>
      <.button phx-click="toggle"> <%= @light_bulb_status %> </.button>

      </div>

      <h1 class= "text-center text-bold md:text-3xl text-1xlmy-3 "> === Exercise # 2 Passing and Handling data ==== </h1>
       <div class="p-5 class text-center">
       <h2 class= "text-center text-bold text-xl"> The Clock </h2>
       <h1><%= @now %></h1>

       </div>


        <h1 class= "text-center text-bold md:text-3xl text-1xlmy-3 "> =========== Exercise # 2 events ========== </h1>
       <div class="p-5 class text-center">
       <h2 class= "text-center text-bold text-xl"> The counter </h2>
       <h1><%= @counter %></h1>
       <div class="d-flex justify-content-around">
       <.button phx-click="increment"> + </.button>
       <.button phx-click="decrement"> - </.button>
       </div>

       </div>

       <div>
        <p> Still want more? </p>
        <.link class="text-blue-700 hover:underline" href={~p"/travel"}>Check out Airport search code </.link>
       </div>
    """

   end

   def handle_event("toggle", _value, socket) do
    new_status = if socket.assigns.light_bulb_status == "on", do: "off", else: "on"
    socket =
      socket
      |> assign(:light_bulb_status, new_status)
    {:noreply, socket}
  end


  def handle_event("increment", _value, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def handle_event("decrement", _value, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter - 1)}
  end

  def handle_info(:tick, socket) do
    socket = assign_current_time(socket)
    {:noreply, socket}
  end

  def assign_current_time(socket) do
    tz = "Africa/Harare" # replace with your timezone
    now = case DateTime.now(tz) do
      {:ok, dt} -> dt
      _error -> DateTime.utc_now()
    end

    now = now
            |> DateTime.to_string()
            |> String.split(".")
            |> hd

    assign(socket, :now, now)
  end

end
