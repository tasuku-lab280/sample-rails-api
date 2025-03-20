# frozen_string_literal: true

class CreateUserAuthProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :user_auth_providers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false

      t.timestamps
    end

    add_index :user_auth_providers, %i[user_id provider], unique: true
    add_index :user_auth_providers, %i[provider uid], unique: true
  end
end
