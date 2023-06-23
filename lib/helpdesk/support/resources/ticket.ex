defmodule Helpdesk.Support.Ticket do
  # This turns this module into a resource
  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]

    create :open do
      accept [:subject]
    end

    update :close do
      accept []
      change set_attribute(:status, :closed)
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

  # require Ash.Query

  # # Save 5 ticket data as Ash.DataLayer.Simple
  # tickets =
  #   for i <- 0..5 do
  #     ticket =
  #       Helpdesk.Support.Ticket
  #       |> Ash.Changeset.for_create(:open, %{subject: "Issue #{i}"})
  #       |> Helpdesk.Support.create!()

  #     if rem(i, 2) == 0 do
  #       ticket
  #       |> Ash.Changeset.for_update(:close)
  #       |> Helpdesk.Support.update!()
  #     else
  #       ticket
  #     end
  #   end

  # # Find the tickets where the subject contains "2"
  # Helpdesk.Support.Ticket
  # |> Ash.Query.filter(contains(subject, "2"))
  # |> Ash.DataLayer.Simple.set_data(tickets)
  # |> Helpdesk.Support.read!()
end
