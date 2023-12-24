defmodule LvnWeb.Layouts do
  use LvnWeb, :html
  use LiveViewNative.Layouts

  embed_templates "layouts/*.html"
end
