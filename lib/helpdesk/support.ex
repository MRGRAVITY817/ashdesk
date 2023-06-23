defmodule Helpdesk.Support do
  use Ash.Api

  # list of resources that can be used with API
  resources do
    registry Helpdesk.Support.Registry
  end
end
