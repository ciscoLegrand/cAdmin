# desc "Explaining what the task does"
# task :cadmin do
#   # Task goes here
# end

namespace :cadmin do
  desc "Update the status of the event to completed if the date of the event has already passed"
  task update_status_event: :environment do
    events = Cadmin::Event.all
    events.each do |event|
      next unless event.status == 'pending'
      if event&.date < Date.today
        event.update(status: 'completed')
        puts "#{event.id} => #{event.status}" 
      end
    end
    puts 'task completed -> status updated'
  end
end