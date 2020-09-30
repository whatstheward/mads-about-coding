class CreatePostTags < ActiveRecord::Migration[5.2]
  def change
    create_table :post_tags do |t|
      t.references :posts
      t.references :tags

      t.timestamps
    end
  end
end
