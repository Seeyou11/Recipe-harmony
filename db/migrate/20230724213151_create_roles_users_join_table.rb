class CreateRolesUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :roles, :users
  end
end
