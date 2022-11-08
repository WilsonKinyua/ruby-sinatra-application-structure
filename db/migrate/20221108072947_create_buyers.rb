class CreateBuyers < ActiveRecord::Migration[6.1]
  def change
    create_table :buyers do |t|
      t.string :name
      t.text :email
      t.text :password
      t.timestamps
    end
  end
end
