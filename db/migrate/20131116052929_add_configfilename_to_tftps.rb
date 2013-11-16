class AddConfigfilenameToTftps < ActiveRecord::Migration
  def change
    add_column :tftps, :configfilename, :string
  end
end
