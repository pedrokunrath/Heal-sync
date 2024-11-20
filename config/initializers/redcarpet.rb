require 'redcarpet'

module MarkdownHandler
  class Renderer < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end
  end

  def self.render(text)
    markdown = Redcarpet::Markdown.new(Renderer, {
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      tables: true,
      highlight: true
    })
    markdown.render(text).html_safe
  end
end
