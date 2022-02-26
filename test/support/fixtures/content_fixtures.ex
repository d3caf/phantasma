defmodule Phantasma.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Phantasma.Content` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type: :image
      })
      |> Phantasma.Content.create_post()

    post
  end

  @doc """
  Generate a submission.
  """
  def submission_fixture(attrs \\ %{}) do
    {:ok, submission} =
      attrs
      |> Enum.into(%{
        status: :posted,
        subs: []
      })
      |> Phantasma.Content.create_submission()

    submission
  end

  @doc """
  Generate a links.
  """
  def links_fixture(attrs \\ %{}) do
    {:ok, links} =
      attrs
      |> Enum.into(%{
        host: "some host",
        url: "some url"
      })
      |> Phantasma.Content.create_links()

    links
  end

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        host: "some host",
        url: "some url"
      })
      |> Phantasma.Content.create_link()

    link
  end
end
