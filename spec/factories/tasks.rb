# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.sentence(word_count: 3) }
    association :project
    expires_at { nil }

    trait :expired do
      expires_at { 1.day.ago }
    end

    trait :with_parent do
      association :parent, factory: :task
    end
  end
end
