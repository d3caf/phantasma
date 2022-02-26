defmodule PhantasmaWeb.Components.SubmissionsTable do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div class="table-container">
      <table class="table is-fullwidth is-hoverable">
        <tbody>
          <%= for %{score: score, thumbnail: thumbnail, title: title, subreddit: subreddit, preview: previews} <- assigns.submissions do %>
          <tr>
            <td class="is-v-center" style="white-space: nowrap;">
              <h4 class="title is-4 has-text-primary-dark" title={"#{score} upvotes"}>
                <ion-icon class="icon" name="arrow-up"></ion-icon>
                <%= score |> Reddex.Helpers.format_upvotes %>
              </h4>
            </td>

            <td class="is-v-center">
              <figure class="image is-48x48 has-background-light">
                <img src={thumb(previews, thumbnail)}>
              </figure>
            </td>

            <td class="is-v-center">
              <strong><%= title %></strong> <small><%= subreddit %></small>
            </td>
          </tr>
          <% end %>
        </tbody>
      </table>
    </div>
    """
  end

  defp thumb(_previews, "self"), do: "https://placehold.co/48"
  defp thumb(_previews, fallback), do: fallback
  defp thumb(%{images: images, enabled: true}, "default") when is_list(images) do
    images
    |> List.first()
    |> Map.get(:resolutions)
    |> Enum.sort_by(&Map.get(&1, :height, 0))
    |> List.first()
    |> Map.get(:url)
  end


end
