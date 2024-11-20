
module Cards
  class RelatedArticleComponent < ViewComponent::Base
    include BlogsHelper
    include Heroicon::Engine.helpers
    def initialize(article:, category: nil)
      @article = article
      @category = category
    end
  end
end