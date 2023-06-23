defmodule Helpdesk.Support.Ticket do
  # This turns this module into a resource
  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  # Simple pieces of data that exist on this resource
  attributes do
    uuid_primary_key :id
    attribute :subject, :string
  end
end
