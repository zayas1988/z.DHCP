class CreateSubnets < ActiveRecord::Migration
  def change
    create_table :subnets do |t|
      t.string :adress
      t.string :mask
      t.string :broadcast
      t.string :routers
      t.string :nameservers
      t.string :domainname

      t.timestamps
    end
	add_index :subnets, :adress, unique: true
  end
end
