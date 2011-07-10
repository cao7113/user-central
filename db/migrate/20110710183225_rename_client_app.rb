class RenameClientApp < ActiveRecord::Migration
  def self.up
    rename_table :clients, :client_apps
  end

  def self.down
    rename_table :client_apps, :clients
  end
end
