class StringCalculator
  def add(pattern="")
    sum(extract_numbers(pattern))
  end

  private
  def extract_numbers(pattern)
    pattern.split(',').compact.map(&:to_i) << 0
  end

  def sum(numbers)
    numbers.reduce(:+)
  end
end
