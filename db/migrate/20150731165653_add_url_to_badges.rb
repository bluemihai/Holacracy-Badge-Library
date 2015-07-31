class AddUrlToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :url, :string
    add_column :badges, :comments, :text
  end
end
