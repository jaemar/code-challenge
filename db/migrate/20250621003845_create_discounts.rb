class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.string :code
      t.json :condition

      t.timestamps
    end
  end
end
