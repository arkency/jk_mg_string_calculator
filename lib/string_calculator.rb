class StringCalculator
  DELIMITER_REGEXP = /\A\/\/(.+|\n)$/

  def add(pattern="")
    sum(extract_numbers(pattern, delimiter(pattern)))
  end

  private
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
    numbers.reduce(0, :+)
  end

  def default_delimiter
    %r{,|\n}
  end
end
