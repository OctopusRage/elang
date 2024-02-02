defmodule Elang do
  defmacro __using__(opts) do
    quote do
      def adapter() do
        unquote(opts[:adapter])
      end

      def base_url() do
        unquote(opts[:base_url])
      end

      def doc(doc, id) do
        if url = base_url(), do: doc(url, doc, id), else: raise "url not set"
      end

      def doc(x, doc, id) do
        adapter().doc(x, doc, id)
      end

      def index(doc, data) do
        if url = base_url(), do: index(url, doc, data), else: raise "url not set"
      end

      def index(x, doc, data) do
        adapter().index(x, doc, data)
      end

      def search(doc, payload) do
        if url = base_url(), do: search(url, doc, payload), else: raise "url not set"
      end

      def search(x, doc, payload) do
        adapter().search(x, doc, payload)
      end

      def insert(doc, data) do
        if url = base_url(), do: insert(url, doc, data), else: raise "url not set"
      end

      def insert(x, doc, data) do
        adapter().insert(x, doc, data)
      end
    end


  end


end
