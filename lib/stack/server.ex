defmodule Stack.Server do
  use GenServer

  # External API

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  # GenServer API

  def init([]) do
    stack = Stack.Stash.get_stack()
    {:ok, stack}
  end

  def handle_call(:pop, _from, [h | t]) do
    {:reply, h, t}
  end

  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end

  def terminate(_reason, stack) do
    Stack.Stash.save_stack(stack)
  end
end
