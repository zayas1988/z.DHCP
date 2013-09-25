class AddDhcpserversSubnets < ActiveRecord::Migration
  def change
    create_table :dhcpservers_subnets do |t|
     t.belongs_to :dhcpserver
     t.belongs_to :subnet
    end 
  end
end
