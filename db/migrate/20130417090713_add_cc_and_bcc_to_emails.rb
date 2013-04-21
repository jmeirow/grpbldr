class AddCcAndBccToEmails < ActiveRecord::Migration
  def change

    # note migration create because it was thought bcc and cc did not exist on emails, but did.
    # still using this migration to remove unwanted column 'body_text' from emails instead
    remove_column :emails, :body_text
  end
end
