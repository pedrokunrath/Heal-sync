# frozen_string_literal: true
module Cards
  class BlogCardComponent < ViewComponent::Base

    def initialize(title:, description:, image:, link:, category:, time_to_read:, link_text: nil)
      @title = title
      @description = description
      @image = image
      @link = link
      @link_text = link_text
      @category = category
      @time_to_read = time_to_read
    end
  end
end
