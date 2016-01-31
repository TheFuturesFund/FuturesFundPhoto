3.times do
  Director.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user: User.new(
      email: Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: "password",
      password_confirmation: "password",
    )
  )
end

10.times do
  Teacher.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user: User.new(
      email: Faker::Internet.email,
      username: Faker::Internet.user_name,
      password: "password",
      password_confirmation: "password",
    )
  )
end

5.times do
  classroom = Classroom.create(
    name: Faker::Lorem.sentence,
  )
  10.times do
    student = Student.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      classroom: classroom,
      user: User.new(
        email: Faker::Internet.email,
        username: Faker::Internet.user_name,
        password: "password",
        password_confirmation: "password",
      )
    )
    3.times do
      album = Album.create(
        student: student,
        name: Faker::Lorem.sentence,
      )
      20.times do
        Photo.create(
          album: album,
          name: Faker::Lorem.sentence,
        )
      end
    end
  end
end
