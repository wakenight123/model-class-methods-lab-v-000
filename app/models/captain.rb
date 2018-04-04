class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).uniq
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboaters
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    Captain.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
