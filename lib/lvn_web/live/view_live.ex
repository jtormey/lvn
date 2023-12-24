defmodule LvnWeb.ViewLive do
  use LvnWeb, :live_view

  def render(%{format: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack>
      <Text>Hello LVN 👏🏻</Text>
      <Image system-name="globe" />
    </VStack>
    """
  end
end
