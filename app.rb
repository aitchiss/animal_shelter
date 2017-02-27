require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/adoption.rb')
require_relative('./controllers/animals_controller.rb')
require_relative('./controllers/owners_controller.rb')
require_relative('./controllers/adoptions_controller.rb')

get '/' do
  @weekly_adoptions = Adoption.weekly_adoptions
  erb(:index)
end