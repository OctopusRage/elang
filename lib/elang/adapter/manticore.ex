defmodule Elang.Adapter.Manticore do
  use Tesla
  @behaviour Elang.Adapter.Base
  plug(Tesla.Middleware.JSON)
  plug(Tesla.Middleware.Headers, [{"content-type", "application/x-ndjson"}])
  adapter(Tesla.Adapter.Gun)

  @spec doc(binary | Tesla.Client.t(), any, any) :: {:error, any} | {:ok, Tesla.Env.t()}
  def doc(url, doc, id) when is_binary(url) do
    client(url) |> doc(doc, id)
  end

  def doc(client, doc, id) do
    get(client, "/doc/#{doc}/#{id}")
  end

  @spec index(binary() | Tesla.Client.t(), any(), map()) :: {:error, any()} | {:ok, Tesla.Env.t()}
  def index(url, doc, data) when is_binary(url) do
    client(url) |> index(doc, data)
  end

  def index(client, doc, data) do
    data = data |> Map.merge(%{index: doc})
    post(client, "/replace", data)
  end

  @spec index(binary | Tesla.Client.t(), any, any, any) :: {:error, any} | {:ok, Tesla.Env.t()}
  def index(url, doc, id, data) when is_binary(url) do
    client(url) |> index(doc, id, data)
  end

  def index(client, doc, id, data) do
    data = data |> Map.merge(%{id: id, index: doc})
    post(client, "/replace", data)
  end

  @spec search(binary() | Tesla.Client.t(), any(), map()) ::
          {:error, any()} | {:ok, Tesla.Env.t()}
  def search(url, doc, payload) when is_binary(url) do
    client(url) |> search(doc, payload)
  end

  def search(client, doc, payload) do
    payload = payload |> Map.merge(%{index: doc})
    post(client, "/search", payload)
  end

  @spec bulk(binary() | Tesla.Client.t(), any()) :: {:error, any()} | {:ok, Tesla.Env.t()}
  def bulk(url, payload) when is_binary(url) do
    client(url) |> bulk(payload)
  end

  def bulk(client, payload) do
    post(client, "/bulk", payload)
  end

  @spec insert(binary() | Tesla.Client.t(), any(), map()) ::
          {:error, any()} | {:ok, Tesla.Env.t()}
  def insert(url, doc, data) when is_binary(url) do
    client(url) |> insert(doc, data)
  end

  def insert(client, doc, data) do
    data = data |> Map.merge(%{index: doc})
    payload = build_item(doc, data)
    post(client, "/insert", payload)
  end

  def build_bulk_item(doc, action, data, id \\ nil) do
    action_payload = if id do
      %{index: doc, doc: data}
    else
      %{index: doc, doc: data, id: id}
    end
    %{"#{action}": action_payload}
  end

  def build_item(doc, data), do: %{index: doc, doc: data}
  def build_item(doc, id, data), do: %{index: doc, id: id, doc: data}

  @spec client(any) :: Tesla.Client.t()
  def client(url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end
end
