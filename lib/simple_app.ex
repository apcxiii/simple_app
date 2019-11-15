defmodule SimpleApp do
  use Application
  require Logger

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    port = Application.get_env(:simple_app, :socket_port)
    Logger.debug("config ===> #{inspect(port)}")
    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(SimpleApp.Endpoint, [])
      # Start your own worker by calling: SimpleApp.Worker.start_link(arg1, arg2, arg3)
      # worker(SimpleApp.Worker, [arg1, arg2, arg3]),
    ]

    children_tcp = [
      {DynamicSupervisor, strategy: :one_for_one, name: SimpleApp.Handler.DynamicSupervisor},
      {Task, fn -> SimpleApp.TcpExample.accept(port) end}
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleApp.Supervisor]
    Supervisor.start_link(children, opts)

    opts_tcp = [strategy: :one_for_one, name: SimpleApp.TcpExample.Supervisor]
    Supervisor.start_link(children_tcp, opts_tcp)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimpleApp.Endpoint.config_change(changed, removed)
  end
end
