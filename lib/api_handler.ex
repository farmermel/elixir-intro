defmodule Myapp.ApiHandler do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_pokemon(id_or_name) do
    GenServer.call(__MODULE__, {:get_poke, id_or_name})
  end

  def terminate(reason, state) do
    :ok
  end

  def handle_call({:get_poke, id_or_name}, _pid, state) do
    {:ok, response} = get_poke_request(id_or_name)
    {:reply, response, state}
  end

  def handle_call(_term, _pid, state) do
    {:reply, [], state}
  end

  def handle_cast(request, state) do
    {:noreply, state}
  end

  def handle_info(term, state) do
    {:noreply, state}
  end

  def get_poke_request(id_or_name) do
    url = api_route("#{id_or_name}")
    case HTTPoison.get(url) do
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
      {:ok, %HTTPoison.Response{body: body}} ->
        {:ok, body }
    end
  end

  defp api_route(path) do
    "https://anapioficeandfire.com/api/characters/#{path}"
  end
end