require "gosu"
require_relative 'bomb'
require_relative 'z_order'

class Player

	TURN_INCREMENT = 4.5
	ACCELERATION = 0.5
	COLLISTION_DISTANCE = 35

	attr_reader :score, :ammo, :x, :y

	def initialize
		@x  = @y = @vel_x = @vel_y = @angle = 0.0
		@score = 0
		@ammo = 0
		@image = Gosu::Image.new("media/starfighter.bmp",
			                            :tileable => true)	
		@beep = Gosu::Sample.new("media/beep.wav")
	end

	def warp(x, y)
		@x, @y = x, y 
	end

	def turn_left
		@angle -= TURN_INCREMENT
	end

	def turn_right
		@angle += TURN_INCREMENT		
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, ACCELERATION)
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
		@x += @vel_x
		@y += @vel_y

		@x %= 640
		@y %= 480

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		@image.draw_rot(@x, @y, ZOrder::PLAYER, @angle)

	end

	def score
		@score
	end

	def ammo
		@ammo
		
	end

	def collect_stars(stars)
		if stars.reject! {|star| colliding?(star)}
			@score += 1
			@beep.play
		end
	end
	def collect_crates(crates)
		if crates.reject! {|crate| colliding?(crate)}
			@ammo += 1
			@beep.play
		end
	end


	def shoot
		
		bomb = Bomb.new
		bomb.warp(@x, @y)
		bomb

		
	end

	

	private
	def colliding?(star)
		Gosu::distance(@x, @y, star.x, star.y) < COLLISTION_DISTANCE
	end	
	def colliding_player?(player)
		Gosu::distance(@x, @y, player.x, player.y) < COLLISTION_DISTANCE
	end	
end	