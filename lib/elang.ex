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

      def index(doc, id) do
        if url = base_url(), do: index(url, doc, id), else: raise "url not set"
      end

      def index(x, doc, id) do
        adapter().doc(x, doc, id)
      end


      def search(doc, payload) do
        if url = base_url(), do: search(url, doc, payload), else: raise "url not set"
      end

      def search(x, doc, payload) do
        adapter().search(x, doc, payload)
      end
    end


  end


end
