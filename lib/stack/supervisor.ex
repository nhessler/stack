defmodule Stack.Supervisor do
  use Supervisor

  def start_link(init_stack) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [init_stack])
    start_workers(sup, init_stack)

    result
  end

  def start_workers(sup, initial_stack) do
    {:ok, _stash} = Supervisor.start_child(sup, worker(Stack.Stash, [initial_stack]))
    {:ok, _pid}   = Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, []))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
