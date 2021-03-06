defmodule Termine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  defp poolboy_config do
    [
      name: {:local, :worker},
      worker_module: Termine.RedisWorker,
      size: 5,
      max_overflow: 2
    ]
  end

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Termine.Repo,
      # Start the Telemetry supervisor
      TermineWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Termine.PubSub},
      # Start the Endpoint (http/https)
      TermineWeb.Endpoint,
      {Task.Supervisor, name: Termine.TaskSupervisor},
      :poolboy.child_spec(:worker, poolboy_config()),
      {Termine.NodeResourceCache,
        [:public, :named_table, :compressed, :set, read_concurrency: true, write_concurrency: true]
      },
      {Termine.PlayerMinerTimestampCache,
        [:public, :named_table, :compressed, :set, read_concurrency: true, write_concurrency: true]
      },
      {Termine.PlayerMinerProducer, 0},
      {Termine.PlayerMinerProducerConsumerCalculateReward, []}
      #Termine.Distributor
      # Start a worker by calling: Termine.Worker.start_link(arg)
      # {Termine.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Termine.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TermineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
