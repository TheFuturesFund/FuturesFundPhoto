[Director, Teacher, Student].each do |klass|
  10.times do
    klass.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      user: User.new(
        email: Faker::Internet.email,
        username: Faker::Internet.user_name,
        password: "password",
        password_confirmation: "password"
      )
    )
  end
end
