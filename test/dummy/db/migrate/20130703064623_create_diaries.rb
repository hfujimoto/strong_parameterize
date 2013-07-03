class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :title, limit: 256
      t.text :content
      t.references :user

      t.timestamps
    end
  end
end
