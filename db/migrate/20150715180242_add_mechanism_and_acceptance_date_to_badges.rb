class AddMechanismAndAcceptanceDateToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :mechanism, :text
    add_column :badges, :acceptance_date, :date
  end
end
