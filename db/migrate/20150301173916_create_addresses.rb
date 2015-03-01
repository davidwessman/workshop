class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :customer, index: true
      t.references :city, index: true
      t.string :street
      t.string :comment

      t.timestamps
    end
  end
end
