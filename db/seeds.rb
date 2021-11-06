# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

ActiveRecord::Base.transaction do 
    User.destroy_all
    Sub.destroy_all
    Post.destroy_all
    PostSubTag.destroy_all

    users = []
    subs = []
    posts = []

    10.times do     # seed random users
        users << User.create!(user_name: Faker::Name.unique.name, 
                            password: Faker::DrivingLicence.uk_driving_licence,
                            email: Faker::Internet.email)
    end

    (0..5).each do |i|
        subs << Sub.create!(title: Faker::Books::Dune.unique.title, 
                            description: Faker::Books::Dune.quote, 
                            subscribed_users: [users[i], users[i+1], users[i+2]], 
                            moderator: users[i+3])
    end

    (6..10).each do |i|
        subs << Sub.create!(title: Faker::Movie.unique.title, 
                            description: Faker::Movies::StarWars.quote, 
                            subscribed_users: [users[i-3], users[i-1], users[i-2]], 
                            moderator: users[i-4])
    end

    (0..5).each do |i|
        posts << Post.create!(title: Faker::Hacker.noun,
                            content: Faker::Hacker.say_something_smart,
                            subs: [subs[i], subs[i+1], subs[i+2]],
                            author: users[i+3])
    end

    (0..5).each do |i|
        posts << Post.create!(title: Faker::Nation.nationality,
                            content: "Our national sport is #{Faker::Nation.national_sport}. And I learn #{Faker::Nation.language}",
                            subs: [subs[i+5], subs[i+4], subs[i+3]],
                            author: users[i])
    end

    comments = []
    (0..5).each do |i|
        comments << Comment.create!(
                    content: "The post made me #{Faker::Emotion.adjective}",
                    post: posts[i+3],
                    author: users[i])
    end

    
    (0..5).each do |i|
        comments << Comment.create!(
                    content: Faker::Movies::HarryPotter.quote,
                    post: posts[i],
                    author: users[i+3])
    end

    nested_comments = []
    
    (0...20).each do |i|
        nested_comments << comments[i % 9].child_comments.create!(
                            content: "Hello world, My name is #{Faker::Name.name}. And I am #{Faker::Job.title}",
                            post: comments[i % 9].post,
                            author: users[(i + 1) % 9])
    end

    (0...20).each do |i|
        nested_comments[i].child_comments.create!(
                            content: Faker::Movies::HarryPotter.quote,
                            post: comments[i % 9].post,
                            author: users[(i + 3) % 9])
    end

    # p1 = Post.create!(title: 'Quraan', description: 'Aya means miracle', sub_ids: [s1.id], author: u1) # Writing s1.id is better than sub_ids:[1]. As after destroying, records may get bigger ids if there where originally records
end