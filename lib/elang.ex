defmodule Elang do
  defmacro __using__(opts) do
    quote do
      def adapter() do
        unquote(opts[:adapter])
      end

      def base_url() do
        unquote(opts[:base_url])
      end

      def doc(x, doc, id) do
        adapter().doc(x, doc, id)
      end

      def index(x, doc, id) do
        adapter().doc(x, doc, id)
      end

      def search(x, doc, payload) do
        adapter().search(x, doc, payload)
      end
    end


  end


end
