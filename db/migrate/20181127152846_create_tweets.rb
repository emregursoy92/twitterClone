class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
