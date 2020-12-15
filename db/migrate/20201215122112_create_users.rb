class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :login
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
