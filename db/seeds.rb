require('pry')
require_relative('../models/animal_type.rb')
require_relative('../models/adoption_status.rb')
require_relative('sql_runner.rb')

AnimalType.delete_all
AdoptionStatus.delete_all

cat_type = AnimalType.new( { 'type' => 'cat' } )
dog_type = AnimalType.new( { 'type' => 'dog' } )
rabbit_type = AnimalType.new( 'type' => 'rabbit' )

cat_type.save
dog_type.save
rabbit_type.save

ready_status = AdoptionStatus.new( { 'status' => 'Ready for adoption' } )
not_ready_status = AdoptionStatus.new( { 'status' => 'Not ready for adoption' } )

ready_status.save
not_ready_status.save


binding.pry
nil