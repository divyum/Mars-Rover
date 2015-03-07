class Rover

	attr_accessor :x, :y, :head, :seq

	def initialize(x, y, head)
		#Initialize Rover position
		@x = x
		@y = y
		@head = head
	end

	def Rover.mat_size(mat_x, mat_y)
		#Initialize Matrix Size
		@@mat_x = mat_x
		@@mat_y = mat_y
	end

	def position
		#Get current posiiton
		[@x, @y, @head]
	end

	def sequence(seq)
		#Initialize sequence and split it to array
		@seq = seq.split(//)
	end

	def start
		#start Rover
		@seq.each do |pos|
			if pos == 'M'
				move
			else
				turn(pos)
			end
		end
	end

	def turn(new_dir)
		directions = ['N', 'E', 'S', 'W']
		index=directions.index(@head)
		if new_dir == 'L'
			index-=1
		else
			index+=1
		end
		@head=directions[index%4]
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
		if @x<0 or @x>@@mat_x or @y<0 or @y>@@mat_y
			raise "Rover reached beyond plane."
		end
	end

end
