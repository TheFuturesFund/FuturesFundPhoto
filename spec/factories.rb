FactoryGirl.define do
  factory :director do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :teacher do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :student do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end

  factory :user do
    email Faker::Internet.email
    username Faker::Internet.user_name
    password "password"
    password_confirmation "password_confirmation"
    factory :director_user do
      association :role, factory: :director
    end
    factory :student_user do
      association :role, factory: :student
    end
    factory :teacher_user do
      association :role, factory: :teacher
    end
  end
end
