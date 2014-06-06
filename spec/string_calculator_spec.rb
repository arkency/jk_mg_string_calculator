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

  it 'can use \n as delimiter' do
    expect(calculator.add("1\n999\n1000")).to eq 2000
  end

  it 'allows you to chose arbitrary delimiter' do
    expect(calculator.add('//

                           1
                           2
                           3')).to eq(6)

    expect(calculator.add('//xyz
                           1xyz2xyz3')).to eq(6)
  end

  it 'should not allow passing negative numbers in pattern' do
    expect { calculator.add('1,2,-3') }.to raise_error(StringCalculator::NegativesNotAllowed)
  end
end
