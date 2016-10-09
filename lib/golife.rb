# Conway's Game of Life Implementation in Ruby
# Author: Vijay Soni(vs4vijay@gmail.com)
require "golife/version"
require "golife/TUI"


class Golife::Game
  attr_accessor :playground, :width, :height, :generation

  def initialize
    self.generation = 0
    self.width = 30
    self.height = 50
    self.playground = self.make_playground(self.height, self.width)
    @tui = TUI.new
  end

  def play
    loop do
      @tui.draw(@generation, @playground)
      next_generation
    end
  ensure
    TUI.endwin
  end

  def make_playground(rows, cols, type = "random")
    (1..rows).map do |i|
      (1..cols).map do |j|
        if type == "empty"
          cell_alive = false
        elsif type == "random"
          cell_alive = Random.new.rand(0..1) == 1
        end
        Cell.new(i, j, cell_alive)
      end
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
