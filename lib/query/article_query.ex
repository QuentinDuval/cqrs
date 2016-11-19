defmodule Query.ArticleQuery do
  use GenServer

  # -----------------------------------------------------------
  # Client API
  # -----------------------------------------------------------

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def stop(server) do
    GenServer.stop(server)
  end

  def clients_of(server, article_id) do
    GenServer.call(server, {:clients_of, article_id})
  end

  def add_purchase(server, client_name, article_id) do
    GenServer.call(server, {:add_purchase, client_name, article_id})
  end


  # -----------------------------------------------------------
  # Private
  # -----------------------------------------------------------

  def init(:ok) do
    state = %{clients_by_article: %{}}
    {:ok, state}
  end

  def handle_call({:clients_of, article_id}, _from, state) do
    {:reply, Map.fetch(state.clients_by_article, article_id), state}
  end

  def handle_call({:add_purchase, client_name, article_id}, _from, state) do
    new_state = update_in(
      state, [:clients_by_article, article_id],
      fn clients ->
        [client_name | clients || []]
      end)
    {:reply, Map.fetch(new_state.clients_by_article, article_id), new_state}
  end

end
