class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :no
      t.string :description

      t.timestamps null: false
    end
  end
end
