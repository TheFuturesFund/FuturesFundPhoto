FactoryGirl.define do
  factory :user do
    classroom
    sequence(:email) { |n| "user_#{n}@example.com" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password "password"
    password_confirmation "password"
    role "student"

    trait :student

    trait :teacher do
      role "teacher"
      classroom nil
    end

    trait :director do
      role "director"
      classroom nil
    end
  end

  factory :album do
    user
    name Faker::Lorem.sentence
  end

  factory :photo do
    album
    name Faker::Lorem.sentence
    image Faker::Internet.url
    category "outtake_category"
  end

  factory :classroom do
    name Faker::Lorem.sentence
  end
end
