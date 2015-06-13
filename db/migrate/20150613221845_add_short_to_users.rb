class AddShortToUsers < ActiveRecord::Migration
  def change
    add_column :users, :short, :string
  end
end
