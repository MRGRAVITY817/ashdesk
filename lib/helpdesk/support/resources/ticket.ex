defmodule Helpdesk.Support.Ticket do
  # This turns this module into a resource
  # Stores in ETS, memory-based Erlang Term Storage.
  use Ash.Resource,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:create, :read, :update, :destroy]

    create :open do
      accept [:subject, :representative_id]
    end

    update :close do
      accept []
      change set_attribute(:status, :closed)
    end

    update :assign do
      accept []

      argument :representative_id, :uuid do
        allow_nil? false
      end

      change manage_relationship(
               :representative_id,
               :representative,
               type: :append_and_remove
             )
    end
  end

  # Simple pieces of data that exist on this resource
  attributes do
    uuid_primary_key :id

    attribute :subject, :string do
      allow_nil? false
    end

    attribute :status, :atom do
      constraints one_of: [:open, :closed]
      default :open
      allow_nil? false
    end
  end

  relationships do
    belongs_to :representative, Helpdesk.Support.Representative do
      attribute_writable? true
    end
  end

  # require Ash.Query

  # tickets =
  #   for i <- 0..5 do
  #     ticket =
  #       Helpdesk.Support.Ticket
  #       |> Ash.Changeset.for_create(:open, %{subject: "Issue #{i}"})
  #       |> Helpdesk.Support.create!()

  #     # For even-number index, we close ticket.
  #     if rem(i, 2) == 0 do
  #       ticket
  #       |> Ash.Changeset.for_update(:close)
  #       |> Helpdesk.Support.update!()
  #     else
  #       ticket
  #     end
  #   end

  # Helpdesk.Support.Ticket
  # |> Ash.Query.filter(contains(subject, "2"))
  # |> Helpdesk.Support.read!()

  # Helpdesk.Support.Ticket
  # |> Ash.Query.filter(status == :closed and not contains(subject, "4"))
  # |> Helpdesk.Support.read!()
end
