class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :title
      t.text :body
      t.references :entry
      t.references :user
      t.string :editor

      t.timestamps
    end
    add_index :revisions, :entry_id
    add_index :revisions, :user_id
  end
end
