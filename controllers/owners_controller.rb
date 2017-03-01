require('sinatra')
require('sinatra/contrib/all')

require_relative('../models/owner.rb')

get '/owners' do
  @owners = Owner.all
  erb(:"owners/index")
end

get '/owners/new' do
  erb(:"/owners/new")
end

get '/owners/:id' do
  @owner = Owner.find(params['id'].to_i)
  erb(:"owners/show")
end

get '/owners/:id/edit' do
  @owner = Owner.find(params['id'].to_i)
  erb(:"owners/edit")
end

get '/owners/:id/match' do
  @owner = Owner.find(params['id'].to_i)
  @matched_animals = @owner.all_adoptable_matches
  
  erb(:"owners/matches")
end

get '/owners/:id/match/:animal_id' do
  @owner = Owner.find(params['id'].to_i)
  @animal = Animal.find(params['animal_id'].to_i)
  erb(:"owners/showanimal")
end

post '/owners' do
  owner = Owner.new(params)
  owner.save
  erb(:"owners/create")
end

post '/owners/:id' do
  @owner = Owner.new(params)
  @owner.update
  redirect to('/owners')
end

post '/owners/:id/delete' do
  @owner = Owner.find(params['id'].to_i)
  if @owner.animals == []
    @owner.delete
    redirect to('/owners')
  else
    @animals = @owner.animals
    erb(:"owners/error")
  end
end