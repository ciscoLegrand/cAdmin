module Cadmin
  class ApplicationMailer < ActionMailer::Base
    default from: 'creadix@creadix.es'
    layout 'mailer'
  end
end
