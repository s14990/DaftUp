# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Games::Witcher.location }
    price { Faker::Number.decimal(2) }
  end
end
