class ChangeDefaultRoleIdInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :role_id, nil
  end
end
