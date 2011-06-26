class CreateSeeds < ActiveRecord::Migration
  def self.up
    create_table :seeds do |t|
      t.string :tag
      t.string :body
      t.datetime :happen_at
      t.string :note

      t.timestamps
    end
  end

  def self.down
    drop_table :seeds
  end
end
