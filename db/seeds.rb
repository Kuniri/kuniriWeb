# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name:  "Lais",
             last_name: "Araujo",
             email: "admin@admin",
             password:              "admin",
             password_confirmation: "admin",
             admin: true)

99.times do |n|
  name  = "Jonas"
  last_name = "Stelth"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  name,
                last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password)
end
