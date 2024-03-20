defmodule Elang.Adapter.Elastic do
  use Tesla
  @behaviour Elang.Adapter.Base
  plug(Tesla.Middleware.JSON)
  adapter(Tesla.Adapter.Hackney)

  @spec doc(binary | Tesla.Client.t(), any, any) :: {:error, any} | {:ok, Tesla.Env.t()}
  def doc(url, doc, id) when is_binary(url) do
    client(url) |> doc(doc, id)
  end

  def doc(client, doc, id) do
    get(client, "_doc/#{doc}/#{id}")
  end

  @spec index(binary | Tesla.Client.t(), any, any, any) :: {:error, any} | {:ok, Tesla.Env.t()}
  def index(url, doc, id, data) when is_binary(url) do
    client(url) |> index(doc, id, data)
  end

  def index(client, doc, id, data) do
    post(client, "_doc/#{doc}/#{id}", data)
  end

  @spec search(binary() | Tesla.Client.t(), any(), any()) ::
          {:error, any()} | {:ok, Tesla.Env.t()}
  def search(url, doc, payload) when is_binary(url) do
    client(url) |> search(doc, payload)
  end

  def search(client, doc, payload) do
    post(client, "/#{doc}/search", payload)
  end

  @spec bulk(binary() | Tesla.Client.t(), any()) :: {:error, any()} | {:ok, Tesla.Env.t()}
  def bulk(url, payload) when is_binary(url) do
    client(url) |> bulk(payload)
  end

  def bulk(client, payload) do
    post(client, "/_bulk", payload)
  end

  def build_bulk_item(doc, action, data, id \\ nil) do
    action_payload = if id do
      %{index: doc, doc: data}
    else
      %{index: doc, doc: data, id: id}
    end
    %{"#{action}": action_payload}
  end

  @spec client(any) :: Tesla.Client.t()
  def client(url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end
end
