require('pry')
require_relative('../models/animal_type.rb')
require_relative('../models/adoption_status.rb')
require_relative('../models/adoption.rb')
require_relative('../models/owner.rb')
require_relative('../models/animal.rb')
require_relative('sql_runner.rb')

Adoption.delete_all
Owner.delete_all
Animal.delete_all
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
adopted_status = AdoptionStatus.new( { 'status' => 'Adopted' } )

adopted_status.save
ready_status.save
not_ready_status.save

barry_the_dog = Animal.new({
  'name' => "Barry",
  'admission_date' => '2017/02/12',
  'type_id' => dog_type.id,
  'breed' => "Labradoodle",
  'adoption_status_id' => ready_status.id,
  'photo_file_path' => "https://s-media-cache-ak0.pinimg.com/originals/98/82/c3/9882c32d02d546fe91aaa4fe85067235.jpg"
  })

barry_the_dog.save

ron_weasley_the_cat = Animal.new ({
  'name' => "Ron Weasley",
  'admission_date' => "2017/01/25",
  'type_id' => cat_type.id,
  'breed' => "British Shorthair",
  'adoption_status_id' => not_ready_status.id,
  'photo_file_path' => "http://writm.com/wp-content/uploads/2016/08/Cat-hd-wallpapers.jpg"
  })

ron_weasley_the_cat.save

mr_flopsy = Animal.new({
  'name' => "Mr Flopsy",
  'admission_date' => "2016/11/01",
  'type_id' => rabbit_type.id,
  'breed' => "Lop Eared",
  'adoption_status_id' => adopted_status.id,
  'photo_file_path' => "http://imgc.allpostersimages.com/images/P-473-488-90/21/2144/XPBCD00Z/posters/petra-wegner-lop-eared-dwarf-rabbit.jpg"
  })

mr_flopsy.save


owner1 = Owner.new({
  'first_name' => "Keith",
  'last_name' => "Douglas",
  'address' => "CodeClan, Castle Terrace, Edinburgh",
  'phone_number' => '07900123456'
  })

owner1.save

owner2 = Owner.new({
  'first_name' => "Craig",
  'last_name' => "Morton",
  'address' => "CodeClan, Castle Terrace, Edinburgh",
  'phone_number' => '01313476521'
  })

owner2.save

adoption_flopsy_keith = Adoption.new({
  'owner_id' => owner1.id,
  'animal_id' => mr_flopsy.id,
  'date' => "2017/01/05"
  })

adoption_flopsy_keith.save

binding.pry
nil