require ('sinatra')
require ('sinatra/contrib/all')
require_relative ('../models/animal.rb')
require_relative ('../models/adoption_status.rb')
require_relative ('../db/sql_runner.rb')

get '/animals' do
  @animals = Animal.all
  erb( :"animals/index" )
end

get '/animals/:id/edit' do
  @animal = Animal.find(params['id'].to_i)
  @adoption_statuses = AdoptionStatus.all
  erb( :"animals/edit" )
end