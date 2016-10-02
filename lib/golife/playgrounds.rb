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
  end
end
