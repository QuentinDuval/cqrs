defmodule Query.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = []
    # TODO - Add an event handler to send the update to the query AC
    supervise(children, strategy: :one_for_one)
  end
end
