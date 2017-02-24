require('sinatra')
require('sinatra/contrib/all')

require_relative('./controllers/animals_controller.rb')

get '/' do
  erb(:index)
end