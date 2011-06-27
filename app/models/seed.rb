class Seed < ActiveRecord::Base
  before_create :check_happen_at
  validates_presence_of :body
  
  #NOTE: good idea?
  def check_happen_at
    self.happen_at=Time.now if self.happen_at.nil?
  end
  
  def happen_at_disp
    happen_at ? happen_at.strftime("%Y%m%d %H:%M") : "00000000 00:00"
  end
  
  def status_color
    #颜色动态变化策略 TODO 
    "##{urgency.to_i}"
  end
end
