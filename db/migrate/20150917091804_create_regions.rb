class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.references :province
      t.string :name
      t.string :kind
      t.timestamps
    end
    add_index :regions, :province_id
  end
end
