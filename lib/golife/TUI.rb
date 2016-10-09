require 'ncurses'

class TUI
  SLEEP_INTERVAL = 0.2
  GAME_HEADING = "\tGame of Life [Generation: %d]"

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
        @window.mvaddstr i + 1, (4 * j + 1) , " #{cell.alive ? '*' : ' '} |"
      end
    end
    Ncurses.refresh
    sleep SLEEP_INTERVAL
  end
end
