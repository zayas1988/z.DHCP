class AddLastpingToHosts < ActiveRecord::Migration
  def change
   add_column :hosts, :lastping, :datetime
   add_index :hosts, :lastping
  end
end
