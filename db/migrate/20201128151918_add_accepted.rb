class AddAccepted < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accepted, :boolean, default: false, null: false
  end
end
