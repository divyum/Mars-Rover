require_relative 'mars_rover'
begin
mat_x, mat_y = gets.chomp.split
Rover.mat_size(mat_x, mat_y)
rescue InputError => e
	puts e.message
	retry
end

while true
	begin
		x ,y, pos = gets.chomp.split
		rover = Rover.new(x, y, pos)
		#break if x==nil
	rescue InputError => e
		puts e.message
		retry
	end
	begin
		seq = gets.chomp.split[0]
		rover.start if rover.sequence(seq)
		print rover.position[0], ' ', rover.position[1], ' ', rover.position[2], "\n" 
	rescue SequenceError => e
		puts e.message
		retry
	end
end