class AddBodyTextAndCommentEmail < ActiveRecord::Migration
  def change
    add_column :emails, :body_text, :text
    add_column :emails, :comments, :text
  end
end
