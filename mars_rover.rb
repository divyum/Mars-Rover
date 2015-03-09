class Rover

	attr_accessor :x, :y, :head, :seq

	def initialize(x ,y, head)
		#Initialize Rover position
		@directions = ['N', 'E', 'S', 'W']
		check_input(x, y, head)
		
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
		if seq==nil
			return false
		end
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
		if @x<0 or @x>@@mat_x or @y<0 or @y>@@mat_y
			raise "Rover reached beyond plane."
		end
	end

	def check_sequence
		@seq.each do |s|
			if s!='M' and s!='L' and s!='R'
				raise "Invalid Move"
			end
		end
	end

	def check_head
		if !@directions.include?(@head)
			raise "Wrong Heading Direction"
		end
	end

	def check_input(x, y, head)
		@x = Integer(x) rescue nil
		@y = Integer(y) rescue nil
		@head = head.upcase rescue nil
		raise "Invalid co-ordinates" if @x==nil or @y==nil
		raise "No head" if @head==nil
		check_head
		check_boundary
	end

end
