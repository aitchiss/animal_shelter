require ('sinatra')
require ('sinatra/contrib/all')
require_relative ('../models/animal.rb')
require_relative ('../db/sql_runner.rb')

get '/animals' do
  @animals = Animal.all
  erb( :"animals/index" )
end