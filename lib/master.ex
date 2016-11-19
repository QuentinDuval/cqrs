defmodule Master do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      supervisor(Query.Supervisor, []), # Query does not depend on commands
      supervisor(Commands.Supervisor, []) # Commands will send to the supervisor
    ]
    supervise(children, strategy: :rest_for_one)
  end
end
