class Blog < ApplicationRecord
  belongs_to :category
  has_one_attached :header_image
end
