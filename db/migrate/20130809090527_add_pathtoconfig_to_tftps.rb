class AddPathtoconfigToTftps < ActiveRecord::Migration
  def change
    add_column :tftps, :pathtoconfig, :string
    add_index :tftps, [:config, :pathtoconfig]
  end
end
