require 'test/unit'
require_relative 'mars_rover'

# Test suite for Rover model class.
class TestRover < Test::Unit::TestCase
  # Test initialization
  def test_initialization
    rover = Rover.new(1, 2, 'W')
    assert_equal 1, rover.x
    assert_equal 2, rover.y
    assert_equal 'W', rover.head
  end

  def test_sequence
  	#Test Sequence
  	rover = Rover.new(1, 2, 'W')
  	rover.sequence("LMLMR")
  	assert_equal ["L", "M", "L", "M", "R"], rover.seq
  end

  def test_position_reporting
    rover = Rover.new(1, 1, 'W')
    assert_equal rover.position, [1, 1, 'W']
  end

  def test_movement
  	Rover.mat_size(5,5)
    # Test movement to North
    rover = Rover.new(1, 1, 'N')
    rover.move
    assert_equal rover.position, [1, 2, 'N']

    # Test movement to East
    rover = Rover.new(1, 1, 'E')
    rover.move
    assert_equal rover.position, [2, 1, 'E']
 
    # Test movement to South
    rover = Rover.new(1, 1, 'S')
    rover.move
    assert_equal rover.position, [1, 0, 'S']
 
    # Test movement to West
    rover = Rover.new(1, 1, 'W')
    rover.move
    assert_equal rover.position, [0, 1, 'W']
  end

  def test_rotation
  	#Test rotation to left
    rover = Rover.new(0, 0, 'N')
    rover.turn('L')
    assert_equal rover.position, [0, 0, 'W']
    
    #Test rotation to Right
    rover = Rover.new(0, 0, 'N')
    rover.turn('R')
    assert_equal rover.position, [0, 0, 'E']
  end

  def test_boundary_case
    #Test the outbound case
    Rover.mat_size(5,5)
    rover = Rover.new(0, -1, 'N')
    assert_raise RuntimeError do
      rover.check_boundary
    end
    rover = Rover.new(0, 0, 'N')
    assert_nothing_raised RuntimeError do
      rover.check_boundary
    end
  end
end