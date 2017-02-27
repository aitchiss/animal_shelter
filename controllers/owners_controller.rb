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
  animals = Animal.all
  @matched_animals = []
  animals.each do |animal|
    if @owner.match(animal.id) == true
      @matched_animals << animal
    end
  end
  erb(:"owners/matches")
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
  owner = Owner.find(params['id'].to_i)
  owner.delete
  redirect to('/owners')
end