class UpdateUsername < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string, :limit=>100, :null=>false
    add_index :users, :username, :unique => true
    add_column :users, :home_url, :string, :limit=>200
  end

  def self.down
    remove_index :users, :username
    remove_column :users, :username
    remove_column :users, :home_url
  end
end
