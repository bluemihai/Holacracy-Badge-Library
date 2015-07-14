class CreateCompTiers < ActiveRecord::Migration
  def change
    create_table :comp_tiers do |t|
      t.string :name
      t.integer :monthly_draw
      t.integer :fixed_draw

      t.timestamps null: false
    end
  end
end
