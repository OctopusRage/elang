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
    Z.search("ax", %{query: %{query_string: "@name tirta AND @user_id 089577683131"}})
  end
end
