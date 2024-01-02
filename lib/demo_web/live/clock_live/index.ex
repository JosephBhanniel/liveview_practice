defmodule DemoWeb.ClockLive.Index do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do

    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

  socket =
   socket
   |> assign_current_time()
   {:ok, socket}
end


 def render(assigns) do

  ~H"""
  <h1 class= "text-center text-bold md:text-3xl text-1xl"> Exercise # 1 Passing and Handling Data</h1>
  <h2 class="font-bold text-xl my-5"> Datetime </h2>
  <div class="text-center text-xl font-bold">
   <%= @now %>
  </div>

  <div class="mt-4">
   <div class="flex justify-between">
   <h3 class="text-xl font-bold text-purple-900">Example Code </h3>
   <button class="bg-purple-900 text-white rounded shadow p-1 mx-3 my-3" onclick="copyCodeToClipboard()">Copy</button>

   </div>
  <pre id="codeSnippet">
      <code>
          <!-- Your code snippet goes here -->
      defmodule DemoWeb.ClockLive.Index do
          use DemoWeb, :live_view

          def mount(_params, _session, socket) do

            if connected?(socket) do
              :timer.send_interval(1000, self(), :tick)
            end

          socket =
            socket
            |> assign_current_time()
            {:ok, socket}
        end
      end
      </code>
  </pre>

  </div>

  <div class="flex my-2 space-x-3">
  <p>Prev :</p>
  <.link class="text-blue-700 hover:underline" href={~p"/light"}>Light </.link>
  <p>Next :</p>
  <.link class="text-blue-700 hover:underline" href={~p"/counter"}>Counter </.link>
  </div>
  """
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
