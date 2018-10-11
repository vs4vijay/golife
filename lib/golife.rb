# Conway's Game of Life Implementation in Ruby
# Author: Vijay Soni(vs4vijay@gmail.com)
require "golife/version"

SLEEP_INTERVAL = 0.2
GAME_HEADING = "Game of Life"

class Golife::Game
  attr_accessor :playground, :width, :height, :generation

  def initialize
    self.generation = 0
    self.width = 10
    self.height = 10
    system "clear"
    puts "What type of board would you like to start with?"
    puts "1. Random (default)"
    puts "2. Empty"
    puts "3. Set each cell manually"
    print "Enter 1, 2 or 3: "
    initial_board = $stdin.gets.chomp
    if initial_board == "2"
      initial_board_type = :empty
    elsif initial_board == "3"
      initial_board_type = :user_input
    else
      initial_board_type = :random
    end
    self.playground = self.make_playground(self.height, self.width, type: initial_board_type)
  end

  def play
    loop do
      system "clear"
      show_playground
      sleep SLEEP_INTERVAL
      next_generation
    end
  end

  def make_playground(rows, cols, type: :random)
    if type == :user_input
      system "clear"
      puts "Press <Enter> to mark a cell as `alive`, or `d` to mark it dead."
      puts "The board is #{width} columns by #{height} rows, for a total of #{width * height} cells."
      puts ""
    end
    (1..rows).map do |i|
      (1..cols).map do |j|
        if type == "empty"
          cell_alive = false
        elsif type == :random
          cell_alive = Random.new.rand(0..1) == 1
        elsif type == :user_input
          print "Should Cell(row=#{j}, col=#{i}) be alive or dead? "
          cell_alive = $stdin.gets.chomp == ""
          puts "Cell(row=#{j}, col=#{i}) with be #{cell_alive ? 'alive' : 'dead'}"
          puts ""
          Cell.new(i, j, cell_alive)
        end
        Cell.new(i, j, cell_alive)
      end
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
