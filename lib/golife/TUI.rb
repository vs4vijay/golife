require 'ncurses'

class TUI
  SLEEP_INTERVAL = 0.2
  GAME_HEADING = "\tGame of Life [Generation: %d]"
  CELL_TEMPLATE = " %s |"

  def initialize
    @window = Ncurses.initscr
    Ncurses.stdscr.nodelay(true)
  end

  def self.endwin
    Ncurses.endwin
  end

  def draw(generation, playground)
    @window.mvaddstr(0, 0, GAME_HEADING % generation)
    playground.each_with_index do |row, i|
      @window.mvaddstr(i + 1, 0, "|")
      row.each_with_index do |cell, j|
        cell =  CELL_TEMPLATE % (cell.alive ? '*' : ' ')
        @window.mvaddstr i + 1, (cell.length * j + 1) , cell
      end
    end
    Ncurses.refresh
    sleep SLEEP_INTERVAL
  end
end
