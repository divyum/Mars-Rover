require_relative 'mars_rover'
mat_x, mat_y = gets.chomp.split()
Rover.mat_size(Integer(mat_x), Integer(mat_y))
while true
	x ,y, pos = gets.chomp.split()
	break if x==nil
	x, y = Integer(x), Integer(y)
	seq = gets.chomp.split()[0]
	rover = Rover.new(x, y, pos)
	rover.sequence(seq)
	rover.start
	print rover.position[0], ' ', rover.position[1], ' ', rover.position[2], "\n" 
end