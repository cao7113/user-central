class UpdateSeeds < ActiveRecord::Migration
  def self.up
    add_column :seeds, :status, :string, :default=>'new', :limit=>50
    add_column :seeds, :urgency, :integer, :default=>0, :limit=>4
  end

  def self.down
    remove_column :seeds, :status
    remove_column :seeds, :urgency
  end
end
