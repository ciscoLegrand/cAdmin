module Cadmin
  class ApplicationMailer < ActionMailer::Base
    default from: ENV['GOOGLE_EMAIL']
    layout 'mailer'
  end
end
