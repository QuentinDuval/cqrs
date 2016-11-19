defmodule Query.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Query.ArticleQuery, [:article_query_server]),
      worker(Query.ClientQuery, [:client_query_server]),
      worker(Query.CommandListener, [:command_listener,
        [{:article_query_server_handler,
          fn c, a -> Query.ArticleQuery.add_purchase(:article_query_server, c, a) end},
         {:client_query_server_handler,
          fn c, a -> Query.ClientQuery.add_purchase(:client_query_server, c, a) end}]
        ])
    ]

    #Query.CommandListener.on_purchase(:command_listener, "john", 2)
    #Query.CommandListener.on_purchase(:command_listener, "judie", 2)
    #Query.ArticleQuery.clients_of(:article_query_server, 2)
    #Query.ClientQuery.article_of(:client_query_server, "john")

    supervise(children, strategy: :rest_for_one)
  end
end
