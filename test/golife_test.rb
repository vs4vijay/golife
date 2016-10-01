require_relative 'test_helper'

class GolifeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Golife::VERSION
  end

  def test_it_does_something_useful
    assert true
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
	  	
	  	it "will not make live cells in empty spaces" do
	  		
	  	end

	  	it "will randomly make live cells if random" do
	  		
	  	end

	  end

	  describe "all methods function correctly" do 
	  	before do
	  		@golife.play
	  	end

	  	it " play" do

	  	end

	  	it "shows playground" do
	  		
	  	end

	  	it "moves to next generation" do
	  		
	  	end

	  	it "will return neighbors of a cell" do
	  		
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


