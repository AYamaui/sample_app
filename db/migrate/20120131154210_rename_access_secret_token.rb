class RenameAccessSecretToken < ActiveRecord::Migration
  def self.up
    rename_column :users, :access_secret, :twitter_access_secret
    rename_column :users, :access_token, :twitter_access_token
  end

  def self.down
  end
end
