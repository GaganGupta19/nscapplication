class AddEventToRegDesk < ActiveRecord::Migration
  def change
    add_reference :reg_desks, :event, index: true, foreign_key: true
  end
end
