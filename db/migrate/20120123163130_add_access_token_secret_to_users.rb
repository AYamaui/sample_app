class AddAccessTokenSecretToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_access_token, :string
    add_column :users, :twitter_access_secret, :string
  end

  def self.down
    remove_column :users, :twitter_access_secret
    remove_column :users, :twitter_access_token
  end
end
