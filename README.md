# SimpleApp

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `iex -S mix phx.server`
  * Open other terminal and type:
  
	```
	curl -X "POST" "http://localhost:4000/api/user" \
     -H 'Accept: application/json' \
     -H 'Content-Type: application/json' \
     -d $'{
  "name": "Name",
  "last_name": "Last"
  
	```
	
  * Read the server terminal to see the receive packet in the socket implementation
  
	```
	iex(1)> [info] POST /api/user
	[debug] Processing with SimpleApp.UserController.create/2
  	Parameters: %{"last_name" => "Last Name", "name" => "Name"}
  	Pipelines: [:api]
	[debug] params ====> %{"last_name" => "Last Name", "name" => "Name"}
	[info] Accpeted new connection
	[debug] socket ===> #Port<0.943>
	[debug] message ===> :ok
	[info] Received packet: "Name Last Name" and send response
	[info] Socket is closed
	[info] Sent 200 in 33ms
	```


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
