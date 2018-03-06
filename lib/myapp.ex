defmodule Myapp do
  @moduledoc """
  Documentation for Myapp.
  """
  use Application
  use Supervisor

  def start(_type, _args) do 
    Supervisor.start_link([{Myapp.Router, []}, {Myapp.ApiHandler, []}], strategy: :one_for_one, name: Myapp.Supervisor)
  end

  @doc """
  Say hello
  ## Parameters
  - name: String of a person

  ## Examples
      iex> Myapp.say("Ari")
      "Hello Ari"
  """

  def say(name) do
    "Hello #{name}"
  end
end
