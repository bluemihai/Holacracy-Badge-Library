class CreateBadgeObjections < ActiveRecord::Migration
  def change
    create_table :badge_objections do |t|
      t.integer :badge_id
      t.integer :librarian_id
      t.boolean :objection

      t.timestamps null: false
    end
  end
end
