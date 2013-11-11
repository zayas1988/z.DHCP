class AddPathtoimageToTftps < ActiveRecord::Migration
  def change
   add_column :tftps, :pathtoimage, :string
  end
end
