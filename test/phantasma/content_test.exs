defmodule Phantasma.ContentTest do
  use Phantasma.DataCase

  alias Phantasma.Content

  describe "posts" do
    alias Phantasma.Content.Post

    import Phantasma.ContentFixtures

    @invalid_attrs %{name: nil, type: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Content.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{name: "some name", type: :image}

      assert {:ok, %Post{} = post} = Content.create_post(valid_attrs)
      assert post.name == "some name"
      assert post.type == :image
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{name: "some updated name", type: :video}

      assert {:ok, %Post{} = post} = Content.update_post(post, update_attrs)
      assert post.name == "some updated name"
      assert post.type == :video
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_post(post, @invalid_attrs)
      assert post == Content.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Content.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Content.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Content.change_post(post)
    end
  end

  describe "submissions" do
    alias Phantasma.Content.Submission

    import Phantasma.ContentFixtures

    @invalid_attrs %{status: nil, subs: nil}

    test "list_submissions/0 returns all submissions" do
      submission = submission_fixture()
      assert Content.list_submissions() == [submission]
    end

    test "get_submission!/1 returns the submission with given id" do
      submission = submission_fixture()
      assert Content.get_submission!(submission.id) == submission
    end

    test "create_submission/1 with valid data creates a submission" do
      valid_attrs = %{status: :posted, subs: []}

      assert {:ok, %Submission{} = submission} = Content.create_submission(valid_attrs)
      assert submission.status == :posted
      assert submission.subs == []
    end

    test "create_submission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_submission(@invalid_attrs)
    end

    test "update_submission/2 with valid data updates the submission" do
      submission = submission_fixture()
      update_attrs = %{status: :pending, subs: []}

      assert {:ok, %Submission{} = submission} = Content.update_submission(submission, update_attrs)
      assert submission.status == :pending
      assert submission.subs == []
    end

    test "update_submission/2 with invalid data returns error changeset" do
      submission = submission_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_submission(submission, @invalid_attrs)
      assert submission == Content.get_submission!(submission.id)
    end

    test "delete_submission/1 deletes the submission" do
      submission = submission_fixture()
      assert {:ok, %Submission{}} = Content.delete_submission(submission)
      assert_raise Ecto.NoResultsError, fn -> Content.get_submission!(submission.id) end
    end

    test "change_submission/1 returns a submission changeset" do
      submission = submission_fixture()
      assert %Ecto.Changeset{} = Content.change_submission(submission)
    end
  end

  describe "link" do
    alias Phantasma.Content.Links

    import Phantasma.ContentFixtures

    @invalid_attrs %{host: nil, url: nil}

    test "list_link/0 returns all link" do
      links = links_fixture()
      assert Content.list_link() == [links]
    end

    test "get_links!/1 returns the links with given id" do
      links = links_fixture()
      assert Content.get_links!(links.id) == links
    end

    test "create_links/1 with valid data creates a links" do
      valid_attrs = %{host: "some host", url: "some url"}

      assert {:ok, %Links{} = links} = Content.create_links(valid_attrs)
      assert links.host == "some host"
      assert links.url == "some url"
    end

    test "create_links/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_links(@invalid_attrs)
    end

    test "update_links/2 with valid data updates the links" do
      links = links_fixture()
      update_attrs = %{host: "some updated host", url: "some updated url"}

      assert {:ok, %Links{} = links} = Content.update_links(links, update_attrs)
      assert links.host == "some updated host"
      assert links.url == "some updated url"
    end

    test "update_links/2 with invalid data returns error changeset" do
      links = links_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_links(links, @invalid_attrs)
      assert links == Content.get_links!(links.id)
    end

    test "delete_links/1 deletes the links" do
      links = links_fixture()
      assert {:ok, %Links{}} = Content.delete_links(links)
      assert_raise Ecto.NoResultsError, fn -> Content.get_links!(links.id) end
    end

    test "change_links/1 returns a links changeset" do
      links = links_fixture()
      assert %Ecto.Changeset{} = Content.change_links(links)
    end
  end

  describe "links" do
    alias Phantasma.Content.Link

    import Phantasma.ContentFixtures

    @invalid_attrs %{host: nil, url: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Content.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Content.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{host: "some host", url: "some url"}

      assert {:ok, %Link{} = link} = Content.create_link(valid_attrs)
      assert link.host == "some host"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{host: "some updated host", url: "some updated url"}

      assert {:ok, %Link{} = link} = Content.update_link(link, update_attrs)
      assert link.host == "some updated host"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_link(link, @invalid_attrs)
      assert link == Content.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Content.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Content.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Content.change_link(link)
    end
  end
end
