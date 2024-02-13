defmodule Y do
  alias Elang.Adapter.Manticore
  def test do
    Z.insert("ax", %{
      name: "aji",
      user_id: "089577682431",
      app_id: 1
    })

    Z.insert("ax", %{
      name: "tirta",
      user_id: "089577683131",
      app_id: 1
    })
  end

  def test_bulk do
    [Manticore.build_bulk_item("ax", "replace", %{
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
    }, 13)] |> Manticore.collect_bulk_items() |> Z.bulk()
  end

  def search do
    Z.search("ax", %{query: %{match: %{"name,user_id": %{query: "tirta", operator: "or"}}}})
  end
end
