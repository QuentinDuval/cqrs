defmodule ClientQueryTest do
  use ExUnit.Case, async: true
  doctest Query.ClientQuery

  setup do
    {:ok, server} = Query.ClientQuery.start_link(:test_server)
    {:ok, server: server}
  end

  test "Can add purchase in the service", %{server: server} do
    assert Query.ClientQuery.article_of(server, "John") == :error
    assert Query.ClientQuery.add_purchase(server, "John", 1) == {:ok, [1]}
    assert Query.ClientQuery.article_of(server, "John") == {:ok, [1]}
  end
end
