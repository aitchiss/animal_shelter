require('pry')
require_relative('../models/animal_type.rb')
require_relative('sql_runner.rb')

cat_type = AnimalType.new( { 'type' => 'cat' } )
dog_type = AnimalType.new( { 'type' => 'dog' } )
rabbit_type = AnimalType.new( 'type' => 'rabbit' )

cat_type.save
dog_type.save
rabbit_type.save


binding.pry
nil