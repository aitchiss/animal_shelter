require('sinatra')
require('sinatra/contrib/all')

get '/searches/new' do
  @animal_types = AnimalType.all
  erb(:"searches/new")
end

post '/searches' do
  type_id = params['type_id'].to_i
  @keyword = params['breed_keyword']
  @matches = Animal.search_for_breed(type_id, @keyword)
  erb(:"searches/index")

end