defmodule PhantasmaWeb.Components.SubSearch do
  use Phoenix.LiveComponent
  alias Breddit.Subreddits
  alias Phoenix.LiveView.JS

  @impl true
  def mount(socket) do
    {:ok, assign(socket, :subs, [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="dropdown is-active" id={"subreddit-results-#{@id}"}>
      <div class="dropdown-trigger">
        <input type="text" phx-keyup={JS.push("change", loading: ".dropdown", target: @myself)} phx-focus={show_dropdown()} phx-debounce="500" />
      </div>
      <div class="dropdown-menu" role="menu" phx-click-away={hide_dropdown()}>
        <div class="dropdown-content">
          <.sub_list subs={@subs} />
        </div>
      </div>
    </div>
    """
  end

  def sub_list(%{subs: subs} = assigns) do
    ~H"""
     <%= for %{"display_name" => name, "id" => id, "icon_img" => icon} <- subs do %>
     <a class="dropdown-item is-flex is-align-items-center ">
       <figure style="border: 1px solid lightgray; border-radius: 24px; overflow: hidden;" class="image is-24x24 mr-2 has-background-light"><img class="is-rounded" src={icon} /></figure>
       <span><%= name %></span>
     </a>
     <% end %>
    """
  end

  @impl true
  def handle_event("change", %{"value" => value}, socket) when not is_nil(value) and value != "" do
    {:ok, res} =
      Subreddits.autocomplete(socket.assigns.reddit, value,
        limit: 10,
        typeahead_active: true,
        raw_json: 1
      )

    subs = get_in(res, ["data", "children"]) |> parse_sub_list()

    {:noreply, socket |> assign(subs: subs)}
  end

  def handle_event("change", _, socket), do: {:noreply, socket}

  def show_dropdown(js \\ %JS{}) do
    js
    |> JS.show(to: "#subreddit-results")
  end

  def hide_dropdown(js \\ %JS{}) do
    js
    |> JS.hide(to: "#subreddit-results")
  end

  defp parse_sub_list(list) do
    Enum.reduce(list, [], fn %{"data" => data}, acc ->
      [data | acc]
    end)
    |> Enum.map(&Map.update!(&1, "icon_img", fn _ -> get_sub_icon(&1) end))
    |> Enum.reverse()
  end

  defp get_sub_icon(%{"community_icon" => icon}) when not is_nil(icon) and icon != "",
    do: icon

  defp get_sub_icon(sub), do: Map.get(sub, "icon_img", "hey")
end
