# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
<<<<<<< HEAD
=======

>>>>>>> 721266809624b699f5477df52229865e1f0e8966
user = User.create!(name: "testuser",
				email: "testuser123@gmail.com",
				password_digest: Digest::SHA1.hexdigest("123456"))