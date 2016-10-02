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


	  	# it "modifies the board each generation" do

	  	# end

	  	it "increments the the generation count" do
	  		before_next = @golife.generation
	  		@golife.next_generation
	  		assert @golife.generation == before_next + 1
	  	end

	  # 	it "moves to next generation" do
	  		
	  # 	end

	  # 	it "will return neighbors of a cell" do
	  		
	  # 	end
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


