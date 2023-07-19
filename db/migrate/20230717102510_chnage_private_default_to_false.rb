class ChnagePrivateDefaultToFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :private, false
  end
end
