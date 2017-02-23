require('pry')
require_relative('../models/animal_type.rb')
require_relative('../models/adoption_status.rb')
require_relative('../models/animal.rb')
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

barry_the_dog = Animal.new({
  'name' => "Barry",
  'admission_date' => '2016/02/12',
  'type_id' => dog_type.id,
  'breed' => "Labradoodle",
  'adoption_status_id' => ready_status.id,
  'photo_file_path' => "https://s-media-cache-ak0.pinimg.com/originals/98/82/c3/9882c32d02d546fe91aaa4fe85067235.jpg"
  })


binding.pry
nil