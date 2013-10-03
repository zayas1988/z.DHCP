class AddRangeToSubnets < ActiveRecord::Migration
  def change
    add_column :subnets, :range, :string
  end
end
