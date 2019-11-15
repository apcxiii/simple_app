defmodule SimpleApp.UserController do
  use SimpleApp.Web, :controller
  alias SimpleApp.Server
  require Logger

  def create(conn, params) do
    Logger.debug("params ====> #{inspect(params)}")

    user_json_schema = generate_user_json_schema()
    user_json_schema |> ExJsonSchema.Schema.resolve()

    case ExJsonSchema.Validator.validate(user_json_schema, params,
           error_formatter: SimpleApp.JsonErrorFormatter
         ) do
      :ok ->
        port = Application.get_env(:simple_app, :socket_port)
        {:ok, socket} = :gen_tcp.connect('127.0.0.1', port, [:binary, packet: 0])
        Logger.debug("socket ===> #{inspect(socket)}")
        message = :gen_tcp.send(socket, params["name"] <> " " <> params["last_name"])
        Logger.debug("message ===> #{inspect(message)}")
        # _ = :gen_tcp.close(socket)

        conn
        |> put_status(:ok)
        |> json(%{message: "success"})

      {:error, errors} ->
        conn
        |> put_status(:bad_request)
        |> render("user_errors.json", %{errors: errors})
    end
  end

  # JSON SCHEMA
  # name String required
  # last_name String required
  defp generate_user_json_schema() do
    %{
      "type" => "object",
      "properties" => %{
        "name" => %{
          "type" => "string"
        },
        "last_name" => %{
          "type" => "string"
        }
      },
      "required" => ["name", "last_name"]
    }
  end
end
