defmodule Y do
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

  def search do
    Z.search("ax", %{query: %{match: %{"name,user_id": %{query: "tirta", operator: "or"}}}})
  end
end
