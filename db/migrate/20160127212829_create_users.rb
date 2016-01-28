class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, unique: true
      t.string :session_token, unique: true

      t.timestamps
    end

    add_index :users, :session_token, unique: true
  end
end
