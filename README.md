# Sinatra Good Reads clone

Portfolio project built to demonstrate the implementation of the following technologies:

 * Sinatra web framework
 * ActiveRecord - associations & migrations(creating multiple tables, models and relationships) and query interface
 * MCV design pattern
 * OOP design in Ruby
 * Sessions and Cookies
 * Restful routes, CRUD & 7 basic REST actions
 * Controllers in Sinatra
 * Password authentication using the Bcrypt ruby gem.
 * Rack Flash messages to display information to the user
 * Validate user input
 * RSpec & TDD
 * 3rd party authentication (optional)


 ## Usage

 To use this app, just clone, run `rake db:migrate`. The app uses the Goodreads API to fetch book data for which you'll need to signup to Goodreads and generate a key. Once you have your key, create a `local_env.rb` file in the config folder, adding the `ENV['GOODREADS_API_KEY']` property and setting the api key as it's value. Don't forget to exclude the file from your repo. To run the app, execute `shotgun` from the command prompt.
