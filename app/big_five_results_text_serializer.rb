class BigFiveResultsTextSerializer
  GENERAL_KEYS = ['NAME', 'EMAIL'].freeze
  SCORE_KEYS = ['EXTRAVERSION', 'AGREEABLENESS', 'CONSCIENTIOUSNESS', 'NEUROTICISM', 'OPENNESS TO EXPERIENCE'].freeze

  def initialize(text)
    @text = text
  end

  def hash
    basic_info.merge score_info
  end

  private

  def basic_info
    {
      'NAME' => my_name,
      'EMAIL' => email
    }
  end

  def score_info
    SCORE_KEYS.each_with_object({}) do |key, obj|
      obj[key] = score_for(key)
    end
  end

  def score_for(key)
    {
      'Overall Score' => overall(key),
      'Facets' => facets(key)
    }
  end

  def overall(key)
    usefull_texts.select { |text| text.include?(key) }.first.split('.').last.to_i
  end

  def facets(key)
    index = usefull_texts.find_index { |text| text.include?(key) }
    {
      usefull_texts[index + 1].split('.').delete_if(&:empty?).first => usefull_texts[index + 1].split('.').delete_if(&:empty?).last.to_i,
      usefull_texts[index + 2].split('.').delete_if(&:empty?).first => usefull_texts[index + 2].split('.').delete_if(&:empty?).last.to_i,
      usefull_texts[index + 3].split('.').delete_if(&:empty?).first => usefull_texts[index + 3].split('.').delete_if(&:empty?).last.to_i,
      usefull_texts[index + 4].split('.').delete_if(&:empty?).first => usefull_texts[index + 4].split('.').delete_if(&:empty?).last.to_i,
      usefull_texts[index + 5].split('.').delete_if(&:empty?).first => usefull_texts[index + 5].split('.').delete_if(&:empty?).last.to_i,
      usefull_texts[index + 6].split('.').delete_if(&:empty?).first => usefull_texts[index + 6].split('.').delete_if(&:empty?).last.to_i
    }
  end

  def my_name
    'Wayne'
  end

  def email
    'wayne.5540@gmail.com'
  end

  def usefull_texts
    @usefull_texts ||= @text.split("\n").keep_if { |string| has_usefull_info?(string) }
  end

  def has_usefull_info?(string)
    ['..'].concat(SCORE_KEYS).any? { |info| string.include? info }
  end

  def text
    @text
  end
end