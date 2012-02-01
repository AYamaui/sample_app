class CreateMailUsers < ActiveRecord::Migration
  def self.up
    create_table :mail_users do |t|
      t.string :mail_name
      t.string :mail_email
      t.string :mail_login

      t.timestamps
    end
  end

  def self.down
    drop_table :mail_users
  end
end
