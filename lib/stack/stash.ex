defmodule Stack.Stash do
  use GenServer

  # API

  def start_link(current_stack) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def save_stack(new_stack) do
    GenServer.cast(__MODULE__, {:save_stack, new_stack})
  end

  def get_stack() do
    GenServer.call(__MODULE__, :get_stack)
  end

  # Implementation

  def handle_call(:get_stack, _from, current_stack) do
    {:reply, current_stack, current_stack}
  end

  def handle_cast({:save_stack, new_stack}, _current_stack) do
    {:noreply, new_stack}
  end
end
