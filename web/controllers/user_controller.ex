defmodule SimpleApp.UserController do
	use SimpleApp.Web, :controller
	require Logger

	def create(conn, params) do
		Logger.debug("params ====> #{inspect(params)}")
		
		port = Application.get_env(:simple_app, :socket_port)

		{:ok, socket} = :gen_tcp.connect('127.0.0.1', port, [:binary, packet: 0])
		Logger.debug("socket ===> #{inspect(socket)}")
    message = :gen_tcp.send(socket, "hola")
    close_ok = :gen_tcp.close(socket)
    

		conn
			|> put_status(:ok)
			|> json(%{message: "success"})
	end
	
end