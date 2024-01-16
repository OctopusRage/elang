defmodule Elang.Adapter.Base do
  @callback doc(url :: binary, doc :: term, id :: term) :: {:ok, body :: term} | {:error, reason :: term}
  @callback doc(client :: Tesla.Client.t, doc :: term, id :: term) :: {:ok, body :: term} | {:error, reason :: term}
  @callback index(url :: binary, doc :: term, id :: term, data :: term) :: {:ok, body :: term} | {:error, reason :: term}
  @callback index(client :: Tesla.Client.t, doc :: term, id :: term, data :: term) :: {:ok, body :: term} | {:error, reason :: term}
  @callback client(url :: binary) :: Tesla.Client.t
end
