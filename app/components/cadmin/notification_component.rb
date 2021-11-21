# frozen_string_literal: true

class Cadmin::NotificationComponent < ViewComponent::Base
  attr_reader :data, :type, :icon, :color_class

  def initialize(notification:)
    
    @type = notification[0]
    @data = prepare_data(notification[1])
    @icon = icon
    @color_class = color_class
  end

  private

  def prepare_data(data)
    case data
    when Hash
      data
    else
      { title: data }
    end
  end

  def icon
    case @type
    # TODO: change notice by success styles
    when 'success'
      inline_svg_tag('cadmin/icons/ico-check-circle.svg', class: 'icon is-medium is-success')
    when 'error'
      inline_svg_tag('cadmin/icons/ico-ban.svg', class: 'icon is-medium is-danger')
    when 'alert'
      inline_svg_tag('cadmin/icons/ico-exclamation-triangle.svg', class: 'icon is-medium is-warning')
    else
      inline_svg_tag('cadmin/icons/ico-information-circle.svg', class: 'icon is-medium is-warning')
    end
  end
  
  def color_class
    case @type
    when 'success'
      'success has-text-success'
    when 'error'
      'error has-text-danger'
    when 'alert'
      'alert has-text-warning'
    else
      'notice has-text-info'
    end
  end

  def render?
    data.present?
  end

end
