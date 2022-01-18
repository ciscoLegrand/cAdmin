module Cadmin
  class UpdateStatusEventJob < ApplicationJob
    queue_as :default

    def perform(events)      
      events.each do |event|
        next unless event.status == 'pending'
        event.update(status: 'completed') if event&.date < Date.today
      end
    end
  end
end
