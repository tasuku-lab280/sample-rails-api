# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :with_auth_provider do
      after(:create) do |user|
        create(:user_auth_provider, user:)
      end
    end
  end
end
