require 'test/unit'
require_relative 'mars_rover'

# Test suite for Rover model class.
class TestRover < Test::Unit::TestCase
  #check matrix coordinates
  def test_matrix_coordinates
    begin
      Rover.mat_size 'E','W'
    rescue InputError => e
      assert_equal "X co-ordinate of plane is not numeric" , e.message
    end
    assert_raise InputError do
      #checks Non Numeric Input 
      Rover.mat_size '2','W'
      Rover.mat_size 'E','2'
      #checks nil input
      Rover.mat_size
    end 
  end

  def test_initialization
    #Test initialization
    Rover.mat_size '5','5'
    rover = Rover.new(1, 2, 'W')
    assert_equal 1, rover.x
    assert_equal 2, rover.y
    assert_equal 'W', rover.head
  end

  def test_bad_input_pos
    Rover.mat_size 5,5

    #Test for invalid input
    assert_raise InputError do
      rover = Rover.new(1)
    end

    #Test for empty input
    assert_raise InputError do
      rover = Rover.new
    end

    #Test input is non-numeric
    assert_raise InputError do
      rover = Rover.new('N', 1, 'W')
    end

    #Test for Heading Direction
    assert_raise InputError do
      rover = Rover.new(1, 1, 'M')
      rover = Rover.new(1, 1)
    end

    assert_nothing_raised InputError do
      rover = Rover.new(1, 1, 'E')
      rover = Rover.new(1, 1, 'e')  #check for downcase head
    end

    #Test for wrong Y co-ordinates input
    assert_raise InputError do
      rover = Rover.new(1, -1, 'S')
    end

    #Test for wrong X co-ordinates input
    assert_raise InputError do
      rover = Rover.new(-9, 1, 'N')
    end
  end

  def test_sequence
    #Test Sequence
    Rover.mat_size 4,4
    rover = Rover.new(1, 2, 'W')
    rover.sequence("LMLMR")
    assert_equal ["L", "M", "L", "M", "R"], rover.seq
  end

  def test_bad_sequence_input
    #Test for sequence input
    Rover.mat_size 5,5
    rover = Rover.new(1, 2, 'W')
    assert_raise SequenceError do
      rover.sequence "LMLMEW"
      rover.sequence
    end

    assert_nothing_raised RuntimeError do
      rover.sequence "LMLM"
      rover.sequence "LmLM" #check for downcase sequence
      rover.sequence "lmlr"
    end
  end

  def test_boundary_case
    #Test the outbound case
    Rover.mat_size 5,5
    assert_raise InputError do
      rover = Rover.new(9, 8, 'N')
    end

    assert_nothing_raised InputError do
      rover = Rover.new(0, 0, 'N')
    end
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

    #Test if move takes rover out of plane
    assert_raise BoundaryError do
      rover = Rover.new(0, 0, 'W')
      rover.move
    end
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
end
