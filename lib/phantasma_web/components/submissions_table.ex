defmodule PhantasmaWeb.Components.SubmissionsTable do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div class="table-container">
      <table class="table is-fullwidth is-hoverable">
        <thead>
          <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        </thead>
        <tbody>
          <%= for %{score: score, thumbnail: thumbnail, title: title, subreddit: subreddit, preview: previews, over_18: nsfw} = submission <- assigns.submissions do %>
          <% IO.inspect(submission, limit: :infinity) %>
          <tr>
            <td class="is-v-center" style="white-space: nowrap;">
              <h4 class="title is-4 has-text-primary-dark" title={"#{score} upvotes"}>
                <ion-icon class="icon" name="arrow-up"></ion-icon>
                <%= score |> Breddit.Helpers.format_upvotes %>
              </h4>
            </td>

            <td class="is-v-center">
              <figure class="image is-48x48 has-background-light">
                <img src={thumb(previews, thumbnail)}>
              </figure>
            </td>

            <td class="is-v-center">
              <strong><%= title %></strong>
              <%= if nsfw, do: ~H|<span class="tag is-danger is-light">🔥 NSFW</span>| %>
            </td>
            <td class="is-v-center">
              <small><%= subreddit %></small>
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
