defmodule ArticleQueryTest do
  use ExUnit.Case, async: true
  doctest Query.ArticleQuery

  setup do
    {:ok, server} = Query.ArticleQuery.start_link(:test_server)
    {:ok, server: server}
  end

  test "Can add clients in the service", %{server: server} do
    assert Query.ArticleQuery.clients_of(server, 1) == :error
    assert Query.ArticleQuery.add_purchase(server, "John", 1) == {:ok, ["John"]}
    assert Query.ArticleQuery.clients_of(server, 1) == {:ok, ["John"]}
  end
end
