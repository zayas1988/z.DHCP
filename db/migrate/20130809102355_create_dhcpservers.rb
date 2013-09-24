class CreateDhcpservers < ActiveRecord::Migration
  def change
    create_table :dhcpservers do |t|
      t.string :ip
      t.integer :sshport
      t.string :configpath
      t.string :reloadcommand
      t.boolean :sync

      t.timestamps
    end
    add_index :dhcpservers, [:ip, :sshport]
    add_index :dhcpservers, [:ip, :sync]
  end
end
