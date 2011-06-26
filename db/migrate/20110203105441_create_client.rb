class CreateClient < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name, :null=>false, :limit=>50      
      t.string :app_id, :null=>false, :limit=>50
      t.string :app_secret, :null=>false, :limit=>50
      t.string :url, :limit=>200
      t.string :description, :limit=>500
      
      t.timestamps
    end
    
    add_index :clients, :name,                :unique => true
    add_index :clients, :app_id,                :unique => true
  end

  def self.down
    drop_table :clients
  end
end
