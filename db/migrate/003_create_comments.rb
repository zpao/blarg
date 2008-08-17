class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :article_id
      t.string :name
      t.string :email
      t.string :url
      t.text :body
      t.text :body_html
      t.boolean :is_author

      t.datetime :created_at
    end
  end

  def self.down
    drop_table :comments
  end
end
