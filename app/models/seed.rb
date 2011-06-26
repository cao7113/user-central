class Seed < ActiveRecord::Base
  before_create :check_happen_at
  
  #NOTE: good idea?
  def check_happen_at
    self.happen_at=Time.now if self.happen_at.nil?
  end
end
