defmodule PhantasmaWeb.SubmissionLive.FormComponent do
  use PhantasmaWeb, :live_component

  alias Phantasma.Content

  @impl true
  def update(%{submission: submission} = assigns, socket) do
    changeset = Content.change_submission(submission)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"submission" => submission_params}, socket) do
    changeset =
      socket.assigns.submission
      |> Content.change_submission(submission_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"submission" => submission_params}, socket) do
    save_submission(socket, socket.assigns.action, submission_params)
  end

  defp save_submission(socket, :edit, submission_params) do
    case Content.update_submission(socket.assigns.submission, submission_params) do
      {:ok, _submission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Submission updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_submission(socket, :new, submission_params) do
    case Content.create_submission(submission_params) do
      {:ok, _submission} ->
        {:noreply,
         socket
         |> put_flash(:info, "Submission created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
