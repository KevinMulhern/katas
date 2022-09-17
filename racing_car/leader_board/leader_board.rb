class LeaderBoard
  def initialize(races)
    @races = races
  end

  def driver_points
    drivers.each_with_object(Hash.new(0)) do |driver, hash|
      hash[driver.name] = driver.points
    end
  end

  def driver_rankings
    drivers.sort_by(&:points).map(&:name).reverse
  end

  private

  def drivers
    @races.flat_map(&:drivers).uniq
  end
end

class Driver
  attr_reader :name, :country
  attr_accessor :points

  def initialize(name, country)
    @name = name
    @country = country
    @points = 0
  end
end

class SelfDrivingCar
  attr_accessor :algorithm_version, :points
  def initialize(algorithm_version, company)
    @algorithm_version = algorithm_version
    @company = company
    @points = 0
  end

  def name
    "Self Driving Car - #{@company} (#{algorithm_version})"
  end
end

class Race
  POINTS = [25, 18, 15]

  attr_reader :drivers

  def initialize(name, drivers)
    @name = name
    @drivers = drivers.each_with_index { |driver, index| driver.points += POINTS[index] }
  end
end
