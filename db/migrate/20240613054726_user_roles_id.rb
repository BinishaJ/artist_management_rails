class UserRolesId < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :role, :role_id
  end
end
