class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.integer :points
      t.integer :circle_id

      t.timestamps null: false
    end
  end
end
