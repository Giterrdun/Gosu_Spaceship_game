require "gosu"
require_relative 'player'
require_relative 'star'
require_relative 'z_order'
require_relative 'crate'
require_relative 'bomb'

class GameWindow < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Gosu Tutorial Game"	

		@background_image = Gosu::Image.new("media/space.png",
			                                 :tileable => true)

		@player = Player.new
		@player2 = Player.new
		@player.warp(width, height/2)	
		@player.warp(width, height/2)

		@crate_anim = Gosu::Image::load_tiles("media/crate.png", 25, 25)
		@crates = []
		
		@star_anim = Gosu::Image::load_tiles("media/star.png", 25, 25)
		@stars = []

		
		@bombs = []

		@font = Gosu::Font.new(20)
		@font2 = Gosu::Font.new(20)

	end

	def update
		@player.turn_left	if Gosu::button_down? Gosu::KbLeft
		@player.turn_right if Gosu::button_down? Gosu::KbRight
		@player.accelerate if Gosu::button_down? Gosu::KbUp
		@bombs << @player.shoot if Gosu::button_down? Gosu::KbEnter

		@player2.turn_left if Gosu::button_down? Gosu::KbA
		@player2.turn_right if Gosu::button_down? Gosu::KbD
		@player2.accelerate if Gosu::button_down? Gosu::KbW
		@bombs << @player2.shoot if Gosu::button_down? Gosu::KbSpace

		@player.move

		@player2.move

		@player.collect_stars(@stars)

		@player2.collect_stars(@stars)

		@player.collect_crates(@crates)

		@player2.collect_crates(@crates)


	

		if rand(10000) < 100 && @stars.size < 25
			@stars.push(Star.new(@star_anim))
		end

		if rand(10000) < 50 && @crates.size < 25
			@crates.push(Crate.new(@crate_anim))
		end

	end

	def draw
		@player.draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		@stars.each {|star| star.draw}
		@crates.each {|crate| crate.draw}
		@font.draw("Score1: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ff0000)

		@player2.draw
		@font2.draw("Score2: #{@player2.score}", width - 100, 10, ZOrder::UI, 1.0, 1.0, 0xff_000099)

		@font.draw("Ammo1: #{@player.ammo}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xff_ff0000)
		@font2.draw("Ammo2: #{@player2.ammo}", width - 100, 30, ZOrder::UI, 1.0, 1.0, 0xff_000099)

		@bombs.each do |bomb|
			bomb.update
			bomb.draw
		end

	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end	

window = GameWindow.new
window.show