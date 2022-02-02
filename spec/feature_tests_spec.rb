require '/Users/Mark/Projects/oystercard3/lib/journey.rb'
require '/Users/Mark/Projects/oystercard3/lib/oystercard.rb'
require '/Users/Mark/Projects/oystercard3/lib/station.rb'

class FeatureTest

  attr_accessor :card

  def initialize
    @card = Oystercard.new
  end

end
