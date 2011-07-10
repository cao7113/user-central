class AddLogoutUrlToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :logout_url, :string, :limit=>500
  end

  def self.down
    remove_column :clients, :logout_url
  end
end
