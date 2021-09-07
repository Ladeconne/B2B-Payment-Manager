class RenameTypeToNature < ActiveRecord::Migration[6.0]
  def change
    rename_column :transactions, :type, :nature
  end
end
