class CreateBlogTaggings < ActiveRecord::Migration
  def change
    create_table :blog_taggings do |t|
      t.integer :editor_user_id, default: 1
      t.references :blog_post
      t.references :blog_tag
      t.timestamps null: false
    end
  end
end
