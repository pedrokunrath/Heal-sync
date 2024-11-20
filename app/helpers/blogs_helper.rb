module BlogsHelper
  def reading_time(text)
    word_count = text.split.size
    words_per_minute = 150
    (word_count.to_f / words_per_minute.to_f).round(1)
  end
end
