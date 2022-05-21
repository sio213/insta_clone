class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.boolean :notification_on_comment, null: false, default: true
      t.boolean :notification_on_like, null: false, default: true
      t.boolean :notification_on_follow, null: false, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
