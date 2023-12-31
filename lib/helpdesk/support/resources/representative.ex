defmodule Helpdesk.Support.Representative do
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string
  end

  relationships do
    # refers `id` field in Ticket
    has_many :tickets, Helpdesk.Support.Ticket
  end
end
