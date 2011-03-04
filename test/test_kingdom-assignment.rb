require 'test/unit'

class TestCalculation < Test::Unit::TestCase
   def test_addition
     #Annahme: 2 und 1+1 sind dasselbe
    assert_equal( 2, 1+1 )
  end
  def test_division
    assert_raise( ZeroDivisionError ){ 1 / 0 }
   end
 end