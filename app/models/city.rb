class City < ActiveRecord::Base


  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods

  def city_openings(arrival, departure)
    dates = arrival..departure
    self.listings.select {|listing| (((listing.reservations) & dates.to_a).empty?)} 
  end

  def reservations
    self.listings.map {|i| i.reservations}
  end

   def ratio
    if listings.count > 0  
      self.reservations.count.to_f / self.listings.count.to_f
    else 
      0
    end
  end

  def self.highest_ratio_res_to_listings
    self.all.max_by {|x| x.ratio}
  end

  def self.most_res
   self.all.max_by {|x| x.reservations.count}

  end



end

