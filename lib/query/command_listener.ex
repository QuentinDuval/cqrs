defmodule Query.CommandListener do
  use GenEvent

  def start_link(name, listeners) do
    res = GenEvent.start_link(name: name)
    for {lid, lf} <- listeners, do: GenEvent.add_mon_handler(name, {Query.CommandListener, lid}, lf)
    res
  end

  def stop(server) do
    GenEvent.stop(server)
  end

  def on_purchase(server, client_name, article_id) do
    GenEvent.ack_notify(server, {:on_purchase, client_name, article_id})
  end

  # -----------------------------------------------------------
  # Private
  # -----------------------------------------------------------

  def init(forward_function) do
    {:ok, forward_function}
  end

  def handle_event({:on_purchase, client_name, article_id}, forward_function) do
    {:ok, _} = forward_function.(client_name, article_id)
    {:ok, forward_function}
  end

end
