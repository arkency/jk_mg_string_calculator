require 'rspec'
require File.join(File.dirname(__FILE__), '..', 'lib/string_calculator')

describe StringCalculator do
  subject(:calculator) { described_class.new }

  it 'returns 0 if empty string provided' do
    expect(calculator.add("")).to eq(0)
  end

  it 'returns number if one number provided' do
    expect(calculator.add("1")).to eq(1)
  end

  it 'returns 0 if no parameters provided' do
    expect(calculator.add).to eq(0)
  end

  it 'returns sum of two numbers when two numbers are provided (separated by comma)' do
    expect(calculator.add('1,2')).to eq(3)
  end

  it 'can take arbitrary count of numbers and make a sum of it' do
    expect(calculator.add('1,2,3,4,5')).to eq(15)
  end
end
