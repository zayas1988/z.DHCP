class ChangeTftpsConfig < ActiveRecord::Migration
  def up
	change_column :tftps, :config, :text
  end

  def down
	change_column :tftps, :config, :string
  end
end
