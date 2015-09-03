class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :password_digest
      t.boolean :admin
      t.string :slug

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :slug
  end
end
