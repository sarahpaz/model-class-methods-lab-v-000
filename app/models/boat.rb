class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where('length < 20')
  end

  def self.ship
    all.where('length > 20')
  end

  def self.last_three_alphabetically
    all.order(:name).last(3).reverse
  end

  def self.without_a_captain
    all.where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group('boats.id').having('count(boats.id) = 3')
  end
end
