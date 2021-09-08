# frozen_string_literal: true

class Cadmin::ModuleCardComponent < ViewComponent::Base
  attr_reader :label, :field, :icon

  def initialize( label:,field:,icon:)
    @label = label 
    @field = field 
    @icon  = icon
  end

  def render?
    @label.present? && @field.present? && @icon.present?
  end

end
