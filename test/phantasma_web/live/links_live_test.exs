defmodule PhantasmaWeb.LinksLiveTest do
  use PhantasmaWeb.ConnCase

  import Phoenix.LiveViewTest
  import Phantasma.ContentFixtures

  @create_attrs %{host: "some host", url: "some url"}
  @update_attrs %{host: "some updated host", url: "some updated url"}
  @invalid_attrs %{host: nil, url: nil}

  defp create_links(_) do
    links = links_fixture()
    %{links: links}
  end

  describe "Index" do
    setup [:create_links]

    test "lists all link", %{conn: conn, links: links} do
      {:ok, _index_live, html} = live(conn, Routes.links_index_path(conn, :index))

      assert html =~ "Listing Link"
      assert html =~ links.host
    end

    test "saves new links", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.links_index_path(conn, :index))

      assert index_live |> element("a", "New Links") |> render_click() =~
               "New Links"

      assert_patch(index_live, Routes.links_index_path(conn, :new))

      assert index_live
             |> form("#links-form", links: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#links-form", links: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.links_index_path(conn, :index))

      assert html =~ "Links created successfully"
      assert html =~ "some host"
    end

    test "updates links in listing", %{conn: conn, links: links} do
      {:ok, index_live, _html} = live(conn, Routes.links_index_path(conn, :index))

      assert index_live |> element("#links-#{links.id} a", "Edit") |> render_click() =~
               "Edit Links"

      assert_patch(index_live, Routes.links_index_path(conn, :edit, links))

      assert index_live
             |> form("#links-form", links: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#links-form", links: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.links_index_path(conn, :index))

      assert html =~ "Links updated successfully"
      assert html =~ "some updated host"
    end

    test "deletes links in listing", %{conn: conn, links: links} do
      {:ok, index_live, _html} = live(conn, Routes.links_index_path(conn, :index))

      assert index_live |> element("#links-#{links.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#links-#{links.id}")
    end
  end

  describe "Show" do
    setup [:create_links]

    test "displays links", %{conn: conn, links: links} do
      {:ok, _show_live, html} = live(conn, Routes.links_show_path(conn, :show, links))

      assert html =~ "Show Links"
      assert html =~ links.host
    end

    test "updates links within modal", %{conn: conn, links: links} do
      {:ok, show_live, _html} = live(conn, Routes.links_show_path(conn, :show, links))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Links"

      assert_patch(show_live, Routes.links_show_path(conn, :edit, links))

      assert show_live
             |> form("#links-form", links: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#links-form", links: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.links_show_path(conn, :show, links))

      assert html =~ "Links updated successfully"
      assert html =~ "some updated host"
    end
  end
end
