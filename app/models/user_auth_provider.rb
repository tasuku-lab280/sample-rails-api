# frozen_string_literal: true

# == Schema Information
#
# Table name: user_auth_providers
#
#  id         :bigint           not null, primary key
#  provider   :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_auth_providers_on_provider_and_uid      (provider,uid) UNIQUE
#  index_user_auth_providers_on_user_id               (user_id)
#  index_user_auth_providers_on_user_id_and_provider  (user_id,provider) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserAuthProvider < ApplicationRecord
  belongs_to :user

  enum :provider, { auth0: 'auth0' }

  validates :provider, presence: true, uniqueness: { scope: :user_id }
  validates :uid, presence: true, uniqueness: { scope: :provider }
end
