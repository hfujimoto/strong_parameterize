class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, limit: 128
      t.integer :age

      t.timestamps
    end
  end
end
