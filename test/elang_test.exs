defmodule ElangTest do
  use ExUnit.Case
  doctest Elang
  alias Elang.{McAdapterTest, Adapter.Manticore}

  test "greets the world" do
    assert {:ok, _} = McAdapterTest.insert("ax", %{
      name: "aji",
      user_id: "089577682431",
      app_id: 1
    })

    assert {:ok, r} = McAdapterTest.search("ax", %{query: %{match: %{"name,user_id": %{query: "aji", operator: "or"}}}})
    # IO.inspect(r)
  end

  test "test bulk" do
    records = [Manticore.build_bulk_item("ax", "replace", %{
      name: "tirta",
      user_id: "089577683131",
      app_id: 1
    }, 13), Manticore.build_bulk_item("ax", "replace", %{
      name: "tirta",
      user_id: "089577683131",
      app_id: 1
    }, 13),
    Manticore.build_bulk_item("ax", "replace", %{
      name: "tirta",
      user_id: "089577683131",
      app_id: 1
    }, 13)] |> Manticore.collect_bulk_items() |> McAdapterTest.bulk()
    IO.inspect(records)
    assert {:ok, _} = records
    # IO.inspect(r)
  end
end
