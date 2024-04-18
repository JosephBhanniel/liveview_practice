defmodule DemoWeb.LightLive.Index do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket =
      socket
      |> assign(light_bulb_status: "off")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-center text-bold md:text-3xl text-1xl">Exercise # 1 Events</h1>

    <h2 class="font-bold text-xl ">The Light Exercise</h2>

    <div class="text-center">
      <p class="p-3 my-1">The light is <%= @light_bulb_status %></p>
      
      <.button phx-click="toggle"><%= @light_bulb_status %></.button>
    </div>

    <div class="mt-4">
      <div class="flex justify-between">
        <h3 class="text-xl font-bold text-purple-900">Example Code</h3>
        
        <button
          class="bg-purple-900 text-white rounded shadow p-1 mx-3 my-3"
          onclick="copyCodeToClipboard()"
        >
          Copy
        </button>
      </div>
       <pre id="codeSnippet">
          <code>
              <!-- Your code snippet goes here -->
          defmodule DemoWeb.LightLive.Index do
            use DemoWeb, :live_view
              def mount(_params, _session, socket) do
                socket =
                 socket
                 |> assign(:light_bulb_status, "off")
                 {:ok, socket}
               end
          end
          </code>
      </pre>
    </div>

    <div class="flex my-2 space-x-3">
      <p>Next :</p>
       <.link class="text-blue-700 hover:underline" href={~p"/clock"}>Date and Clock </.link>
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
end
