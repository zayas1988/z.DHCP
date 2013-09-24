class AddLockToDhcpservers < ActiveRecord::Migration
  def change
    add_column :dhcpservers, :lock, :boolean
  end
end
