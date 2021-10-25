# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do 
    User.destroy_all
    Sub.destroy_all
    Post.destroy_all

    u1 = User.create!(user_name: 'aya', password: 'ayaland')
    u2 = User.create!(user_name: 'kevin', password: 'keviny')

    s1 = Sub.create!(title: 'islam', description: 'Peace', moderator: u2)
    s2 = Sub.create!(title: 'sports', description: 'Mo salah', moderator: u1)

    p1 = Post.create!(title: 'Quraan is paradise', sub: s1, author: u1)
    p2 = Post.create!(title: 'Best world player', sub: s2, author: u2)
end