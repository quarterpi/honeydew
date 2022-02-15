defmodule HoneydewWeb.PageControllerTest do
  use HoneydewWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Honeydew · Phoenix Framework"
  end
end
