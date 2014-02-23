class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :username
      t.string :uid
      t.string :token
      t.string :secret
      t.references :user, index: true

      t.timestamps
    end
  end
end
