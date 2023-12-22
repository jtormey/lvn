defmodule Lvn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LvnWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:lvn, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lvn.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Lvn.Finch},
      # Start a worker by calling: Lvn.Worker.start_link(arg)
      # {Lvn.Worker, arg},
      # Start to serve requests, typically the last entry
      LvnWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lvn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LvnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
