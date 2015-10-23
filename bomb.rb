require "gosu"
require_relative 'player'
require_relative 'z_order'


class Bomb

	def initialize
		@image = Gosu::Image.new("media/bomb.png", :tileable => true)
		@x = @y = @vel_x = @vel_y = 0.0

	end

	def warp(x, y)
		@x, @y = x, y
	end

	def accelerate
		@vel_x += Gosu::offset_x(0.0, 0.25)
		@vel_y += Gosu::offset_y(0.0, 0.25)
	end

	def move
		@x += @vel_x
		@y += @vel_y
		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def update
		accelerate
		move
		
		
	end

	def draw 
		@image.draw_rot(@x, @y, 3, 0.0)
		
	end

end