class UserRolesTable < ActiveRecord::Migration[7.1]
  def change
    rename_column(Role, :roles, :role)
  end
end
