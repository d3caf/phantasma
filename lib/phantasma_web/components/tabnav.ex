defmodule PhantasmaWeb.Components.Tabnav do
  use Phoenix.Component

  def render(assigns) do
    ~H"""
    <div class="tabs is-medium">
      <ul>
        <li class="is-active"><a>Posts</a></li>
        <li><a>Submissions</a></li>
        <li><a>Links</a></li>
      </ul>
    </div>
    """
  end
end
