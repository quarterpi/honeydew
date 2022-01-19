defmodule HoneydewWeb.PageController do
  use HoneydewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
