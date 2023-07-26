# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# # db/seeds.rb
super_admin_role = Role.create!(name: 'Super Admin')
staff_role = Role.create!(name: 'Staff')


# Create universal permission to manage all models
manage_all = Permission.create!(subject_class: 'all', action: 'manage')

# Assign manage_all permission to the Super Admin role
super_admin_role.permissions << manage_all

# Create a user with the Super Admin role
user = User.create!(
  email: 'superadmin@example.com',
  full_name: 'Super admin',
  username: 'superadmin',
  password: '123123',
  password_confirmation: '123123'
)
 user.roles << super_admin_role

Permission.create!(subject_class: "Recipe", action: "index")
Permission.create!(subject_class: "Recipe", action: "show")
Permission.create!(subject_class: "Recipe", action: "create")
Permission.create!(subject_class: "Recipe", action: "update")
Permission.create!(subject_class: "Recipe", action: "destroy")

Permission.create!(subject_class: "Category", action: "index")
Permission.create!(subject_class: "Category", action: "show")
Permission.create!(subject_class: "Category", action: "create")
Permission.create!(subject_class: "Category", action: "update")
Permission.create!(subject_class: "Category", action: "destroy")

Permission.create!(subject_class: "User", action: "index")
Permission.create!(subject_class: "User", action: "show")
Permission.create!(subject_class: "User", action: "create")
Permission.create!(subject_class: "User", action: "update")
Permission.create!(subject_class: "User", action: "destroy")