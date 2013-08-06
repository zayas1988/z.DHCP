class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :hostname
      t.string :ip
      t.string :mac
 #     t.boolean :usetftp
      t.string :discription
      t.integer :tftp_id
      t.integer :subnet_id
      t.timestamps
    end
add_index :hosts, [:subnet_id, :ip]
  end
end
