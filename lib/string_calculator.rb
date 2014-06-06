class StringCalculator
  def add(pattern="")
    extracted_numbers(pattern).reduce(&:+).to_i
  end

  def extracted_numbers(pattern)
    first_number, second_number = pattern.split(',').map(&:to_i)

    [first_number, second_number].compact
  end
end
