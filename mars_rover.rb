class InputError < RuntimeError
end

class SequenceError < RuntimeError
end

class BoundaryError <RuntimeError
end

class Rover

	attr_accessor :x, :y, :head, :seq

	def initialize(x=nil, y=nil, head=nil)
		#Initialize Rover position
		@directions = ['N', 'E', 'S', 'W']
		check_input(x, y, head)
	end

	def Rover.mat_size(mat_x=nil, mat_y=nil)
		#Initialize Matrix Size
		self.check_mat_size mat_x, mat_y
	end

	def position
		#Get current posiiton
		[@x, @y, @head]
	end

	def sequence(seq)
		#Initialize sequence and split it to array
		raise SequenceError, "No sequence entered" if seq==nil or seq=="\n"
		@seq = seq.upcase.split(//)
		check_sequence
	end

	def start
		#start Rover
		@seq.each do |pos|
			pos == 'M' ? move : turn(pos)
		end
	end

	def turn(new_dir)
		index=@directions.index(@head)
		new_dir == 'L'? index-=1 : index+=1
		@head=@directions[index%4]
	end

	def move
		#Move ahead
		case @head
		when "N" then @y+=1 #Move North
		when "E" then @x+=1 #Move East
		when "S" then @y-=1 #Move South
		when "W" then @x-=1 #Move West
		end
		check_boundary
	end

	def check_boundary
		#Check if the Rover is in plane or not
		raise BoundaryError, "Rover reached beyond plane." if @x<0 or @x>@@mat_x or @y<0 or @y>@@mat_y
	end

	def check_sequence
		@seq.each do |s|
			raise SequenceError, "Invalid Moves" unless ['M','L','R'].include?s
		end
	end

	def check_input(x, y, head)
		#check inputs x, y, head
		raise InputError, 'X co-ordinate of rover is empty' if x==nil or x=="\n"
		raise InputError, 'Y co-ordinate of rover is empty' if y==nil or y=="\n"
		raise InputError, 'Head of rover is empty' if head==nil or head=="\n"
		@x = Integer(x) rescue nil
		raise InputError, "X co-ordinate of rover is not numeric" unless @x.is_a? Numeric
		@y = Integer(y) rescue nil
		raise InputError, "Y co-ordinate of rover is not numeric" unless @y.is_a? Numeric
		raise InputError, "Head of rover is invalid" if head.size>1 or head.is_a? Numeric or !@directions.include?(head.upcase)
		@head = head.upcase
		#check_head
		raise InputError, "Rover position is out of the plane" if @x<0 or @x>@@mat_x or @y<0 or @y>@@mat_y
		#check_boundary
	end

	def Rover.check_mat_size(mat_x, mat_y)
		#Check the matrix size
		raise InputError, 'X co-ordinate of plane is empty' if mat_x==nil or mat_x=="\n"
		raise InputError, 'Y co-ordinate of plane is empty' if mat_y==nil or mat_y=="\n"
		@@mat_x = Integer(mat_x) rescue nil
		raise InputError, 'X co-ordinate of plane is not numeric' unless @@mat_x.is_a? Numeric
		@@mat_y = Integer(mat_y) rescue nil
		raise InputError, 'Y co-ordinate of plane is not numeric' unless @@mat_y.is_a? Numeric
	end

end
