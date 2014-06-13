class StringCalculator
  DELIMITER_REGEXP = /\A\/\/(.+|\n)$/
  
  class NegativesNotAllowed < StandardError
    def initialize(negatives_found)
      @negatives_found = negatives_found
    end

    attr_reader :negatives_found
  end

  def add(pattern="")
    extracted_numbers = extract_numbers(pattern, delimiter(pattern))
    negatives = negatives_within(extracted_numbers)
    raise NegativesNotAllowed.new(negatives) unless negatives.empty?
    sum(extracted_numbers)
  end

  private
  def negatives_within(number_sequence)
    number_sequence.find_all { |n| n < 0 }
  end

  def extract_numbers(pattern, delimiter)
    pattern
      .gsub(DELIMITER_REGEXP,'')
      .split(delimiter)
      .compact
      .map(&:to_i)
  end

  def delimiter(pattern)
    parser = DelimiterParser.new

    delimiters = parser.delimiters(pattern)

    reg = Regexp.new(delimiters.map { |delim| Regexp.escape(delim) }.join('|'))
    reg
  end

  def sum(numbers)
    numbers.reject{|x| x > 1000}.reduce(0, :+)
  end

  def default_delimiter
    %r{,|\n}
  end
end

class DelimiterParser
  MULTIPLE_DELIMITER_REGEXP = %r{\[(.*?)\][\[|\n]}

  def initialize(default_delimiters = [',', "\n"])
    @default_delimiters = default_delimiters
  end

  def delimiters(pattern)
    if pattern.start_with?('//')
      delimiters_parsed(pattern)
    else
      default_delimiters
    end
  end

  private
  def delimiters_parsed(pattern)
    stripped_pattern = pattern[2..-1]
    delimiters_pattern = stripped_pattern.dup
    delimiters = []

    if stripped_pattern.start_with?('[')
      while delimiters_pattern.start_with?('[')
        delimiter, delimiters_pattern = parse_multiple_delimiters(delimiters_pattern)
        delimiters << delimiter
      end
    else
      delimiters << parse_single_delimiter(delimiters_pattern) 
    end

    delimiters
  end

  def parse_multiple_delimiters(delimiters_pattern)
    match = delimiters_pattern.match(MULTIPLE_DELIMITER_REGEXP)
    token = match[1]

    [token, delimiters_pattern[(token.length + 2)..-1]]
  end

  def parse_single_delimiter(delimiters_pattern)
    token = delimiters_pattern.chars.take_while { |c| c != "\n" }.join
    if token.empty?
      token = delimiters_pattern.chars.take_while { |c| c == "\n" }.tap { |arr| arr.pop }.join
    end

    token
  end
  attr_reader :default_delimiters
end
