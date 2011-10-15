require 'helper'

class BlackBoxTest < Test::Unit::TestCase
  def test_without_parameters
    #This test does not make a whole lot of sense...
    result = %x[bin/kingdom-assignment]
    expected = "Invalid arguments, see --help for more information."
    assert_equal expected.strip, result.strip
  end
  
  def test_small
    %x[rm test/data/out_3.csv]
    %x[bin/kingdom-assignment -i test/data/in_3.xml -o test/data/out_3.csv]
    result = File.open("test/data/out_3.csv").read
    target = File.open("test/data/target_3.csv").read

    assert_not_nil result
    assert_not_nil target

    assert_equal target, result, "Output of out_3.xml invalid"
    %x[rm test/data/out_3.csv]
  end

  def test_medium
    %x[rm test/data/out_medium.csv]
    %x[bin/kingdom-assignment -i test/data/in_medium.xml -o test/data/out_medium.csv]
    result = File.open("test/data/out_medium.csv").read
    target = File.open("test/data/target_medium.csv").read

    assert_not_nil result
    assert_not_nil target

    assert_block "Output of out_medium.xml invalid." do
      result == target
    end
    %x[rm test/data/out_medium.csv]
    
  end
  
end

