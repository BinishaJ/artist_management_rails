class DateDataType < ActiveRecord::Migration[7.1]
  def change
    change_column(:users, :dob, :date)
  end
end
