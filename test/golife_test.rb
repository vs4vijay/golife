require 'test_helper'

class GolifeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Golife::VERSION
  end

  def test_horizontal_blinker_next_generation_is_vertical
    blinker = Golife::Game.new.tap do |b|
      b.width  = 3
      b.height = 3
      b.playground = blinker_horizontal_playground
    end

    blinker.next_generation

    assert_equal blinker_vertical_playground, blinker.playground
  end

  def test_vertical_blinker_next_generation_is_horizontal
    blinker = Golife::Game.new.tap do |b|
      b.width  = 3
      b.height = 3
      b.playground = blinker_vertical_playground
    end

    blinker.next_generation

    assert_equal blinker_horizontal_playground, blinker.playground
  end

  def blinker_horizontal_playground
    [
      [Cell.new(1, 1), Cell.new(1, 2), Cell.new(1, 3)],
      [Cell.new(2, 1, true), Cell.new(2, 2, true), Cell.new(2, 3, true)],
      [Cell.new(3, 1), Cell.new(3, 2), Cell.new(3, 3)]
    ]
  end

  def blinker_vertical_playground
    [
      [Cell.new(1, 1), Cell.new(1, 2, true), Cell.new(1, 3)],
      [Cell.new(2, 1), Cell.new(2, 2, true), Cell.new(2, 3)],
      [Cell.new(3, 1), Cell.new(3, 2, true), Cell.new(3, 3)]
    ]
  end
end
