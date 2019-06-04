class AddEmailNullToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string, :null => true
  end
end
