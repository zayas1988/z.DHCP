class AddLeasetimeToSubnets < ActiveRecord::Migration
  def change
   add_column :subnets, :leasetime, :integer
  end
end
