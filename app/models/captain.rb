class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(:boats => :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    joins(:boats => :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
