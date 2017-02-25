require ('sinatra')
require ('sinatra/contrib/all')
require_relative ('../models/animal.rb')
require_relative ('../models/adoption_status.rb')
require_relative ('../models/adoption.rb')
require_relative ('../models/animal_type.rb')
require_relative ('../db/sql_runner.rb')

get '/animals' do
  @animals = Animal.all
  @header = "animals: all"
  @types = AnimalType.all
  erb( :"animals/index" )
end

get '/animals/adoptable' do
  @animals = Animal.get_all_adoptable
  @types = AnimalType.all
  @header = "animals: all adoptable"
  erb(:'animals/index')
end

get '/animals/types/:id' do
  @animals = Animal.get_by_type(params['id'].to_i)
  type = @animals[0].get_type
  @types = AnimalType.all
  @header = "animals: all #{type}s"
 
  erb(:"animals/index")
  
end


get '/animals/new' do
  @adoption_statuses = AdoptionStatus.all
  @animal_types = AnimalType.all
  @date = Date.today.to_s
  date_components = @date.split('-')
  date_components.reverse!
  @date = date_components.join('/')

  erb(:"animals/new")
end

get '/animals/:id' do
  @animal = Animal.find(params['id'].to_i)
  erb( :"animals/show" )
end

get '/animals/:id/edit' do
  @animal = Animal.find(params['id'].to_i)
  @adoption_statuses = AdoptionStatus.all
  @animal_types = AnimalType.all
  erb( :"animals/edit" )
end



post '/animals' do
  animal = Animal.new(params)
  animal.admission_date = animal.admission_date_formatted
  animal.save
  erb(:'animals/create')
end

post '/animals/:id' do
  animal = Animal.find(params['id'].to_i)
  adoption_status_id = params['adoption_status_id'].to_i
  animal.change_adoption_status(adoption_status_id)
  animal.name = params['name']
  animal.breed = params['breed']
  animal.update
  redirect to('/animals')

end

post '/animals/:id/delete' do
  animal = Animal.find(params['id'].to_i)
  animal.delete
  redirect to('/animals')
end

# get '/animals/type/:id' do
#   # get all animals of type :id
# end

