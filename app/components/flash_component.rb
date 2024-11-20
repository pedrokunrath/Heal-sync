# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(flash:)
    super

    @messages = []
    flash.each do |type, msg|
      @messages << {
        type:,
        message: msg || '',
        class: type == 'notice' ? 'text-success-500' : 'text-danger-500',
        icon: type == 'notice' ? 'check' : 'exclamation-circle'
      }
    end
  end

end
