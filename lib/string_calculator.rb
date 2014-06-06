class StringCalculator
  def add(pattern="")
    sum(extract_numbers(pattern))
  end

  private
  def extract_numbers(pattern)
    pattern.split(allowed_delimiters).compact.map(&:to_i) << 0
  end

  def sum(numbers)
    numbers.reduce(:+)
  end

  def allowed_delimiters
    %r{,|\n}
  end
end
