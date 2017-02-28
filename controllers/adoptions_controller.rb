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

get '/adoptions/new/:owner_id/:animal_id' do
  @animals = Animal.all
  @owners = Owner.all
  @owner = Owner.find(params['owner_id'].to_i)
  @animal = Animal.find(params['animal_id'].to_i)
  erb(:"adoptions/new")
end


post '/adoptions' do
  owner_id = params['owner_id'].to_i
  owner = Owner.find(owner_id)
  animal_id = params['animal_id'].to_i

  if owner.match(animal_id)

    date = Date.today
    adoption = Adoption.new({
      'owner_id' => owner_id,
      'animal_id' => animal_id,
      'date' => date
      })
    adoption.save
    adoption.finalise_adoption(animal_id, owner_id)
  
    redirect to('/owners')

  else
    erb(:"adoptions/error")

  end
end