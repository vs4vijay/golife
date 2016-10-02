# Conway's Game of Life Implementation in Ruby
# Author: Vijay Soni(vs4vijay@gmail.com)
require "golife/version"
require "golife/playgrounds"

SLEEP_INTERVAL = 0.2
GAME_HEADING = "Game of Life"

class Golife::Game
  attr_accessor :playground, :width, :height, :generation

  def initialize(type = "random")
    self.generation = 0
    self.width = 10
    self.height = 10
    self.playground = Golife::Playgrounds.playground_for(type).build(height, width)
  end

  def play
    loop do
      system "clear"
      show_playground
      sleep SLEEP_INTERVAL
      next_generation
    end
  end

  def show_playground
    puts "\t#{GAME_HEADING} [Generation: #{@generation}]"
    @playground.each_with_index do |row, i|
      print "|"
      row.each_with_index do |cell, j|
	      print " #{cell.alive ? '*' : ' '} |"
      end
      print "\n\n"
    end
  end

  def next_generation
    @generation += 1

    dying_cells   = []
    growing_cells = []

    @playground.each do |row|
      row.each do |cell|
        live_neighbours = neighbours_of(cell).select(&:alive?).length

        if cell.alive? && (live_neighbours < 2 || live_neighbours > 3)
          dying_cells << cell
        elsif cell.dead? && live_neighbours == 3
          growing_cells << cell
        end
      end
    end

    dying_cells.each(&:dead!)
    growing_cells.each(&:live!)
  end

  private

    def neighbours_of(cell)
      @playground.flatten.map do |n_cell|
	       n_cell if [cell.x + 1, cell.x, cell.x - 1].include?(n_cell.x) && [cell.y + 1, cell.y, cell.y - 1].include?(n_cell.y)
      end.compact.reject{|c| c.x == cell.x && c.y == cell.y}
    end

end

class Cell
  attr_accessor :x, :y, :alive

  def initialize(x, y, alive = false)
    self.x = x
    self.y = y
    self.alive = alive
  end

  def alive?
    @alive
  end

  def dead?
    !@alive
  end

  def dead!
    @alive = false
    self
  end

  def live!
    @alive = true
    self
  end

  def to_s
    "x: #{@x}, y: #{@y}"
  end

  def ==(other)
    x == other.x && y == other.y && alive == other.alive
  end
end

Golife::Game.new.play if __FILE__ == $0
