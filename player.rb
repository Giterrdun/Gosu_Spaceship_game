require "gosu"

class Player

	TURN_INCREMENT = 4.5
	ACCELERATION = 0.5

	def initialize
		@x  = @y = @vel_X = @vel_y = @angle = 0.0
		@score = 0
		@image = Gosu::Image.new("media/starfighter.bmp",
			                            :tilleable => true)	
	end

	def warp(x, y)
		@x. @y = x, y 
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT		
	end

	def accelerate
		@vel_x += Gous::offset_x(@angle, ACCELERATION)
		@vel_y += Gous::offset_y(@angle, ACCELERATION)
	end

	def move
		@x += @vel_X
		@y += @vel_y

		@x %= 640
		@y % = 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def drar
		@image.draw_rota(@x, @y, 1, @angle)
	end

end	