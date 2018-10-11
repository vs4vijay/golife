require_relative 'test_helper'

class GolifeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Golife::VERSION
  end

  def test_it_does_something_useful
    assert true
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


  describe Golife do
  	before do
	    @golife = Golife::Game.new
	  end
	  describe "it initializes a new game correctly" do
	  	it "starts at generation 0" do
	  		assert_equal @golife.generation, 0
	  	end
	  
	  	it "has a width of 10" do 
	  		assert_equal @golife.width, 10
	  	end

	  	it "has a height of 10" do 
	  		assert_equal @golife.height, 10
	  	end

	  	it "generates a correct playground" do 
	  		@golife.playground.each do |dim| 
	  			assert_equal dim.length, 10
	  		end
	  	end



	  end

	  describe "makes a playground" do
	  	
	  	it "will randomly make live cells" do
	  		5.times do
	  			if Golife::Game.new != @golife
	  				assert true
	  			end
	  		end
	  	end

	  	it "will return a collection" do
	  		assert_equal @golife.make_playground(1,1).class, Array
	  	end

	  	it "will return a collection of cells" do
	  		assert_equal @golife.make_playground(1,1)[0][0].class, Cell
	  	end

	  end

	  describe "show playground" do 

	  	it "will return a collection" do
	  		assert_equal @golife.show_playground.class, Array
	  	end

	  	it "will print" do
	  		assert_output() { @golife.show_playground }
	  	end

	  end

	  describe "next generation" do

	  	it "increments the the generation count" do
	  		before_next = @golife.generation
	  		@golife.next_generation
	  		assert @golife.generation == before_next + 1
	  	end

		end



  end



  describe Cell do
	  before do
	    @cell = Cell.new(1,2, true)
	  end

	  describe "Cells initialize correctly" do
	    it "is alive" do
	      @cell.alive.must_equal true
	    end

	    it "has a position" do
	      assert_equal @cell.x, 1
	      assert_equal @cell.y, 2
	    end

	  end

	  describe "Cells function" do
	  	it "will return it's alive" do
	  		@cell.alive?.must_equal true
	  	end
	  		
	  	it "will return it's not dead" do
	  		@cell.dead?.must_equal false
	  	end

	  	it "will die when killed" do
	  		@cell.dead!
	  		@cell.dead?.must_equal true
	  	end

	  	it "will become alive when brought to life..." do
	  		@cell.dead!
	  		@cell.live!
	  		@cell.alive?.must_equal true
	  	end

	  	it "return string coordinates" do
	  		@cell.to_s.must_equal "x: 1, y: 2"
	  	end



	  end

	end


end


