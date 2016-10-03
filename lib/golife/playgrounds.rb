require "set"

module Golife
  module Playgrounds
    def self.playground_for(type)
      const_get(type.to_s.capitalize)
    rescue NameError
      Random
    end

    module Random
      def self.build(rows, cols)
        (1..rows).map do |i|
          (1..cols).map do |j|
            Cell.new(i, j, [true, false].sample)
          end
        end
      end
    end

    module Blinker
      def self.build(rows, cols)
        blink_row = rows / 2

        mid_col    = cols / 2
        blink_cols = Set.new([mid_col - 1, mid_col, mid_col + 1])

        (1..rows).map do |i|
          (1..cols).map do |j|
            Cell.new(i, j, i == blink_row && blink_cols.include?(j))
          end
        end
      end
    end

    module Blocker
      def self.build(rows, cols)
        starting_blocks = Set.new([
          [1, 7], [1, 9],
          [2, 6],
          [3, 1], [3, 2], [3, 5], [3, 10],
          [4, 1], [4, 2], [4, 4], [4, 7], [4, 9], [4, 10],
          [5, 5], [5, 6]
        ])

        (1..rows).map do |i|
          (1..cols).map do |j|
            Cell.new(i, j, starting_blocks.include?([i, j]))
          end
        end
      end
    end
  end
end
