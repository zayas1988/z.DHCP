class CreateTftpservers < ActiveRecord::Migration
  def change
    create_table :tftpservers do |t|
      t.string :ip
      t.integer :sshport
      t.string :tftppath
      t.boolean :sync

      t.timestamps
    end
  add_index :tftpservers, [:ip, :sshport]
  add_index :tftpservers, [:ip, :sync]
  end
end
