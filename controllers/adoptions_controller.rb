require ('sinatra')
require ('sinatra/contrib/all')
require('date')
require_relative ('../models/animal.rb')
require_relative ('../models/adoption_status.rb')
require_relative ('../models/adoption.rb')
require_relative ('../models/animal_type.rb')
require_relative ('../db/sql_runner.rb')

get '/adoptions/new' do
  @animals = Animal.all
  @owners = Owner.all
  erb(:"adoptions/new")
end


post '/adoptions' do
  date = Date.today
  owner_id = params['owner_id'].to_i
  animal_id = params['animal_id'].to_i
  adoption = Adoption.new({
    'owner_id' => owner_id,
    'animal_id' => animal_id,
    'date' => date
    })
  adoption.save
  animal = Animal.find(animal_id)
  animal.process_adoption
  redirect to('/owners')
end