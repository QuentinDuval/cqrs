defmodule CQRS do
  use Application

  @doc """
  Callback to initialize the application
  """
  def start(_type, _args) do
    Master.start_link
  end
end
