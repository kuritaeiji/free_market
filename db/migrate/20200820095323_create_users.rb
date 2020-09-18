class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string(:email, null: false, index: true)
      t.string(:password_digest, null: false)
      t.string(:nickname, null: false)
      t.string(:family_name, null: false)
      t.string(:first_name, null: false)
      t.string(:postal_code, null: false)
      t.text(:address, null: false)
      t.timestamps
    end
  end
end
