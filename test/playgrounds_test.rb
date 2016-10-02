require 'test_helper'

class PlaygroundsTest < Minitest::Test
  def test_playground_for_random_is_random
    actual = Golife::Playgrounds.playground_for("random")

    assert_equal Golife::Playgrounds::Random, actual
  end

  def test_playground_for_unknown_is_random
    actual = Golife::Playgrounds::playground_for("unknown_pattern")

    assert_equal Golife::Playgrounds::Random, actual
  end
end
