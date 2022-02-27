defmodule PhantasmaWeb.SubmissionLive.Index do
  use PhantasmaWeb, :live_view

  alias Phantasma.Content
  alias Phantasma.Content.Submission
  alias PhantasmaWeb.Components.SubmissionsTable, as: SubmissionsComponent
  alias Breddit.Users

  @post_params ~W(title id post_hint media_embed is_original_content is_self preview over_18 subreddit gildings approved_at_utc
  view_count clicked permalink category url score thumbnail subreddit_id num_comments thumbnail_width
  thumbnail_height upvote_ratio name)a

  @impl true
  def mount(_params, %{"reddit_current_user" => %{name: username}}, socket) do
    if connected?(socket) do
      {:ok, assign(socket, :submissions, list_submissions(socket.assigns.reddit, username))}
    else
      {:ok, socket |> assign(submissions: [], loading: true)}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Submission")
  #   |> assign(:submission, Content.get_submission!(id))
  # end

  # defp apply_action(socket, :new, _params) do
  #   socket
  #   |> assign(:page_title, "New Submission")
  #   |> assign(:submission, %Submission{})
  # end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Submissions")
    |> assign(:submission, nil)
  end

  # @impl true
  # def handle_event("delete", %{"id" => id}, socket) do
  #   submission = Content.get_submission!(id)
  #   {:ok, _} = Content.delete_submission(submission)

  #   {:noreply, assign(socket, :submissions, list_submissions(socket.assigns.reddit))}
  # end

  defp list_submissions(client, username) do
    {:ok, res} = Users.submitted(client, username)

    get_in(res, [:data, :children])
    |> Enum.map(fn %{data: data} ->
      data
      |> Map.take(@post_params)
    end)
  end
end
