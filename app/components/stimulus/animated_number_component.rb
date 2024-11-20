# frozen_string_literal: true
module Stimulus
  class AnimatedNumberComponent < ViewComponent::Base
    def initialize(start_value:, end_value:, duration:)
      @start_value = start_value
      @end_value = end_value
      @duration = duration
    end

  end
end
