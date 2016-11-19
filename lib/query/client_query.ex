defmodule Query.ClientQuery do
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

  def article_of(server, client_name) do
    GenServer.call(server, {:client_article, client_name})
  end

  def add_article(server, client_name, article_id) do
    GenServer.call(server, {:new_article, client_name, article_id})
  end


  # -----------------------------------------------------------
  # Private
  # -----------------------------------------------------------

  def init(:ok) do
    state = %{articles_by_client: %{}, client_names: %{}}
    {:ok, state}
  end

  def handle_call({:client_article, client_name}, _from, state) do
    {:reply, Map.fetch(state.articles_by_client, client_name), state}
  end

  def handle_call({:new_article, client_name, article_id}, _from, state) do
    new_state = update_in(
      state, [:articles_by_client, client_name],
      fn articles ->
        [article_id | articles || []]
      end)

    #get_in(%{"toto" => %{"titi" => 1}}, ["toto", "titi"])
    #update_in(%{"toto" => %{"titi" => 1}}, ["toto", "titi"], &(&1 + 1))

    {:reply, Map.fetch(new_state.articles_by_client, client_name), new_state}
  end

end
