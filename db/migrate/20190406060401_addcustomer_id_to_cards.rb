class AddcustomerIdToCards < ActiveRecord::Migration[5.2]
  def up
    add_reference :cards, :user, index: true
  end

  def down
    remove_reference :cards, :user, index: true
  end
end
