class AddUserIdToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :user_id, :integer, :null=>false #client属于某个用户或系统管理员
  end

  def self.down
    remove_column :clients, :user_id
  end
end
