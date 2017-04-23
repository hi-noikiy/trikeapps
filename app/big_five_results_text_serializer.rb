class BigFiveResultsTextSerializer
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
      obj[key] = score(key)
    end
  end

  def my_name
    'Wayne'
  end

  def email
    'wayne.5540@gmail.com'
  end

  def score(key)
    {
      'Overall Score' => overall(key),
      'Facets' => facets(key)
    }
  end

  def overall(key)
    remove_non_digits(usefull_texts[index(key)]).to_i
  end

  def facets(key)
    index = index(key)

    6.times.with_object({}) do |i, obj|
      obj[remove_dots remove_digits usefull_texts[index + i + 1]] = remove_non_digits(usefull_texts[index + i + 1]).to_i
    end
  end

  def index(key)
    usefull_texts.find_index { |text| text.include?(key) } || raise("Can't find key #{key}")
  end

  def remove_dots(string)
    string.gsub('.', '')
  end

  def remove_digits(string)
    string.gsub(%r(\d), '')
  end

  def remove_non_digits(string)
    string.gsub(%r(\D), '')
  end

  def usefull_texts
    @usefull_texts ||= @text.split("\n").keep_if { |paragraph| has_usefull_info?(paragraph) }
  end

  def has_usefull_info?(paragraph)
    keywords.any? { |keyword| paragraph.include? keyword }
  end

  def keywords
    [facet_prefix_sign].concat(SCORE_KEYS)
  end

  def facet_prefix_sign
    '..'
  end
end