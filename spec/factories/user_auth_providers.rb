# frozen_string_literal: true

FactoryBot.define do
  factory :user_auth_provider do
    user
    provider { :auth0 }
    uid { 'uid' }
  end
end
