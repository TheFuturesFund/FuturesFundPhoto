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
    password_confirmation "password"
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

  factory :album do
    student
    name Faker::Lorem.sentence
  end

  factory :photo do
    album
    name Faker::Lorem.sentence
    image Faker::Internet.url
    category 'outtake_category'     
  end

  factory :classroom do
    name Faker::Lorem.sentence
  end

  factory :classroom_student do
    student
    classroom
  end
end
