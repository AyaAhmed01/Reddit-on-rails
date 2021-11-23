# Reddit On Rails
A social media website mimics Reddit with its functionalities. 
Users can sign up and log in. Logged in users can create and subscribe to subs, write posts and tagging them to different subs, comment on other posts, reply to comments and upvote/downvote posts and comments.


### Tools
* Ruby on Rails for backend and development
* Postgresql engine for database management
* Used [Faker gem](https://github.com/faker-ruby/faker) to seed database generating fake data such as names, job titles, books titles and quotes.
* Used [FriendlyId gem](https://github.com/norman/friendly_id) to create URL's with human-friendly strings instead of numeric ids for ActiveRecord models
* Used [letter opener gem](https://github.com/ryanb/letter_opener) to preview activation emails in browser instead of sending them in development environment

### Live demo
In [this live version](https://on-rails-reddit.herokuapp.com/subs) you can browse the website's subs, users, posts and comments. But features requiring log in such as creating posts are only available in development environment yet.
