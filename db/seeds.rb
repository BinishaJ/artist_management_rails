# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

%w[super_admin artist_manager artist].each do |role|
  Role.find_or_create_by({role: role})
end

p "Roles added to roles table"

User.create(first_name: 'First', last_name: 'Last', email: 'admin@gmail.com', password: 'password', phone: '24976143', address: 'Admin Address', role_id: 1, gender: 'f', dob: '2001-12-23')

p "Admin created"