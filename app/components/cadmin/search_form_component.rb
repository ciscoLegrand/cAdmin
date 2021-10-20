# frozen_string_literal: true
class Cadmin::SearchFormComponent < ViewComponent::Base
  attr_reader :path, :parametters, :button

  def initialize(path:, params:,  button:)
    @path = path
    @parametters = params
    
    @button = button.present? ? button : 'Buscar' 
  end

end
