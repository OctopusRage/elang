defmodule ElangTest do
  use ExUnit.Case
  doctest Elang

  test "greets the world" do
    assert Elang.hello() == :world
  end
end
