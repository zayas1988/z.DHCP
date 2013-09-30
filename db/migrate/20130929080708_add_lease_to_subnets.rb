class AddLeaseToSubnets < ActiveRecord::Migration
  def change
    add_column :subnets, :guest, :boolean
      
  end
end
