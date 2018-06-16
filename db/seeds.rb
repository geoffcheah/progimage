# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: "g@gmail.com", password: "123456")

picture = Picture.create!({
      name: "IMG_8394.JPG",
      description: "first image record in db",
      remote_url: "https://s3-eu-west-1.amazonaws.com/progimage30/image_uploads/IMG_8394.JPG",
      user: user
    })
