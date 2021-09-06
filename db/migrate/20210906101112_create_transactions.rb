class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :type
      t.string :company_paid
      t.date :date
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
