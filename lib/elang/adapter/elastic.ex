defmodule Elang.Adapter.Elastic do
  use Tesla
  @behaviour Elang.Adapter.Base
  adapter(Tesla.Adapter.Gun)

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

  @spec client(any) :: Tesla.Client.t()
  def client(url) do
    middleware = [
      {Tesla.Middleware.BaseUrl, url},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end
end
