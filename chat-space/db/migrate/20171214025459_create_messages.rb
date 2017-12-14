class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text  :body
      t.string  :image
      t.string  :user_id, null: false, foreign_key: true
      t.string  :group_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
