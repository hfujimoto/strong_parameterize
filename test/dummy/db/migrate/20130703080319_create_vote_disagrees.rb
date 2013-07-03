class CreateVoteDisagrees < ActiveRecord::Migration
  def change
    create_table :vote_disagrees do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
