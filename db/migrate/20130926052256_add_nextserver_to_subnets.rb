class AddNextserverToSubnets < ActiveRecord::Migration
  def change
    add_column :subnets, :nextserver, :string
  end
end
