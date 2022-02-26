defmodule PhantasmaWeb.SubmissionLive.Show do
  use PhantasmaWeb, :live_view

  alias Phantasma.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:submission, Content.get_submission!(id))}
  end

  defp page_title(:show), do: "Show Submission"
  defp page_title(:edit), do: "Edit Submission"
end
