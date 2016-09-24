#!/usr/bin/env ruby
# Conway's Game of Life Implementation in Ruby
# Author: Vijay Soni(vs4vijay@gmail.com)
class Golife
  attr_accessor :playground, :width, :height, :iteration
 
  def initialize
    self.iteration = 0
    self.width = 10
    self.height = 10
    self.playground = self.make_playground(self.width, self.height) 
  end

  def play
    puts "Play"
    loop do
      system "clear" 
      show_playground
      sleep 0.2
      next_generation
    end
  end
  
  def make_playground(rows, cols, type = "random")
    (0..rows).map do |i|
      (0..cols).map do |j|
      	if type == "empty"
      	  cell_alive = false
      	elsif type == "random"
      	  cell_alive = Random.new.rand(0..1) == 1 
      	end
      	Cell.new(i, j, cell_alive)
      end
    end    
  end

  def show_playground
    puts "\tGame of Life [Iteration: #{@iteration}]"
    @playground.each_with_index do |row, i|
      print "|"    
      row.each_with_index do |cell, j|
	      print " #{cell.alive ? '*' : ' '} |"
      end
      print "\n\n"
    end
  end

  def next_generation
    @iteration += 1 
    @playground = @playground.map do |row|
      row.map do |cell|
        # cell.alive = Random.new.rand(0..1) == 1
      	live_neighbours = neighbours_of(cell).select{|c| c.alive?}
      	if(cell.alive? && (live_neighbours.size == 2 || live_neighbours.size == 3))
      	  cell.dup.live!
      	elsif(cell.dead? && live_neighbours.size == 3)
          cell.dup.live!		
      	else
      	  cell.dup.dead!
      	end
      end
    end
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

end

Golife.new.play if __FILE__ == $0
