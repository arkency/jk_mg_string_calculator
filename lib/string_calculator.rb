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
    if DELIMITER_REGEXP =~ pattern
      $1
    else
      default_delimiter
    end
  end

  def sum(numbers)
    numbers.reject{|x| x > 1000}.reduce(0, :+)
  end

  def default_delimiter
    %r{,|\n}
  end
end
