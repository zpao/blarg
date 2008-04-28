class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :blurb
      t.text :blurb_html
      t.text :body
      t.text :body_html
      t.string :permalink
      t.boolean :published
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
