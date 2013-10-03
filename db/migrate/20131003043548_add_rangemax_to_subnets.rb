class AddRangemaxToSubnets < ActiveRecord::Migration
  def change
   add_column :subnets, :rangemax, :string
  end
end
