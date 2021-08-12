defmodule TermineWeb.PageController do
  use TermineWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
