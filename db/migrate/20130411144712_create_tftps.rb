class CreateTftps < ActiveRecord::Migration
  def change
    create_table :tftps do |t|
      t.string :image
      t.string :group
      t.string :config

      t.timestamps
    end
    add_index :tftps, [:image, :group]
  end
end
