require 'rspec'

describe StringCalculator do
  subject { described_class.new }

  it 'returns 0 if empty string provided' do
    expect(subject.add("")).to eq(0)
  end
end
