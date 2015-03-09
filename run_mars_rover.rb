require_relative 'mars_rover'
mat_x, mat_y = gets.chomp.split
Rover.mat_size(Integer(mat_x), Integer(mat_y))
while true
	x ,y, pos = gets.chomp.split
	break if x==nil
	#raise "Invalid Input" if x!=nil and y==nil
	rover = Rover.new(x, y, pos)
	seq = gets.chomp.split[0]
	if rover.sequence(seq)
		rover.start
	end
	print rover.position[0], ' ', rover.position[1], ' ', rover.position[2], "\n" 
end