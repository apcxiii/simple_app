use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :simple_app, SimpleApp.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :simple_app, socket_port: 7000, ip: {127,0,0,1}