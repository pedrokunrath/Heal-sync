# frozen_string_literal: true

module Faqs
  class FaqQuestionComponent < ViewComponent::Base
    renders_one :answer
    def initialize(question:, options: {})

      @question = question
      @options = options
    end
  end
end
