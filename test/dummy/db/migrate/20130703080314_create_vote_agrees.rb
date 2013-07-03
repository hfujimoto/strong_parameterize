class CreateVoteAgrees < ActiveRecord::Migration
  def change
    create_table :vote_agrees do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
