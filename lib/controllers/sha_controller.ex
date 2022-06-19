defmodule ShaController do
  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Parsers,
    parsers: [:json, :urlencoded],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  post "/sha1" do
    response = SHAService.sha1(conn.body_params["string"], conn.body_params["encoding"])
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, :ok, ResponseFormater.create(response))
  end
  
  post "/sha224" do
    response = SHAService.sha224(conn.body_params["string"], conn.body_params["encoding"])
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, :ok, ResponseFormater.create(response))
  end

  post "/sha256" do
    response = SHAService.sha256(conn.body_params["string"], conn.body_params["encoding"])
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, :ok, ResponseFormater.create(response))
  end

  post "/sha384" do
    response = SHAService.sha384(conn.body_params["string"], conn.body_params["encoding"])
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, :ok, ResponseFormater.create(response))
  end

  post "/sha512" do
    response = SHAService.sha512(conn.body_params["string"], conn.body_params["encoding"])
    conn = put_resp_content_type(conn, "application/json")
    send_resp(conn, :ok, ResponseFormater.create(response))
  end

  match _ do
    send_resp(conn, :not_found, "Not Found")
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
      IO.inspect(kind, label: :kind)
      IO.inspect(reason, label: :reason)
      IO.inspect(stack, label: :stack)
      send_resp(conn, conn.status, "Algo salio mal")
  end

end
