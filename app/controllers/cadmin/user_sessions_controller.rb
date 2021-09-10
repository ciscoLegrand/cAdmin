module Cadmin
  class UserSessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
  end
end