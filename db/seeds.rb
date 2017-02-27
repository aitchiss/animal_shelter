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

ready_status = AdoptionStatus.new( { 'status' => 'ready for adoption' } )
not_ready_status = AdoptionStatus.new( { 'status' => 'not ready for adoption' } )
adopted_status = AdoptionStatus.new( { 'status' => 'adopted' } )

adopted_status.save
ready_status.save
not_ready_status.save

barry_the_dog = Animal.new({
  'name' => "Barry",
  'admission_date' => '2017/02/12',
  'type_id' => dog_type.id,
  'breed' => "Labradoodle",
  'adoption_status_id' => ready_status.id,
  'photo_file_path' => "https://s-media-cache-ak0.pinimg.com/originals/98/82/c3/9882c32d02d546fe91aaa4fe85067235.jpg",
  'needs_outside_space' => 'true',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'true',
  'needs_special_attention' => 'false'
  })

barry_the_dog.save

ron_weasley_the_cat = Animal.new ({
  'name' => "Ron Weasley",
  'admission_date' => "2017/01/25",
  'type_id' => cat_type.id,
  'breed' => "British Shorthair",
  'adoption_status_id' => not_ready_status.id,
  'photo_file_path' => "http://writm.com/wp-content/uploads/2016/08/Cat-hd-wallpapers.jpg",
  'needs_outside_space' => 'false',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'false',
  'needs_special_attention' => 'true'
  })

ron_weasley_the_cat.save

mr_flopsy = Animal.new({
  'name' => "Mr Flopsy",
  'admission_date' => "2016/11/01",
  'type_id' => rabbit_type.id,
  'breed' => "Lop Eared",
  'adoption_status_id' => adopted_status.id,
  'photo_file_path' => "http://imgc.allpostersimages.com/images/P-473-488-90/21/2144/XPBCD00Z/posters/petra-wegner-lop-eared-dwarf-rabbit.jpg",
  'needs_outside_space' => 'false',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'true',
  'needs_special_attention' => 'false'
  })

mr_flopsy.save


galactus = Animal.new({
  'name' => "Galactus",
  'admission_date' => "2017/02/01",
  'type_id' => dog_type.id,
  'breed' => "Staffordshire Bull Terrier",
  'adoption_status_id' => ready_status.id,
  'photo_file_path' => "http://i48.tinypic.com/280mej9.jpg",
  'needs_outside_space' => 'true',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'true',
  'needs_special_attention' => 'true'
  })

galactus.save

mabel = Animal.new({
  'name' => "Mabel",
  'admission_date' => "2016/12/26",
  'type_id' => cat_type.id,
  'breed' => "Tabby",
  'adoption_status_id' => not_ready_status.id,
  'photo_file_path' => "https://s-media-cache-ak0.pinimg.com/564x/e5/1f/25/e51f2549f5e539c6cfd8e325a83651b5.jpg",
  'needs_outside_space' => 'true',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'false',
  'needs_special_attention' => 'true'
  })

mabel.save

hulk_the_cat = Animal.new({
  'name' => "Hulk Hogan",
  'admission_date' => "2016/12/01",
  'type_id' => cat_type.id,
  'breed' => "Persian",
  'adoption_status_id' => ready_status.id,
  'photo_file_path' => "http://elelur.com/data_images/cat-breeds/persian-cat/persian-cat-04.jpg",
  'needs_outside_space' => 'false',
  'can_live_with_children' => 'true',
  'can_live_with_same_type' => 'true',
  'can_live_with_other_type' => 'true',
  'needs_special_attention' => 'false'
  })

hulk_the_cat.save



owner1 = Owner.new({
  'first_name' => "Keith",
  'last_name' => "Douglas",
  'address' => "CodeClan, Castle Terrace, Edinburgh",
  'phone_number' => '07900123456',
  'has_outside_space' => 'true',
  'has_children_at_home' => 'true',
  'has_cats' => 'false',
  'has_dogs' => 'false',
  'has_rabbits' => 'true',
  'can_give_special_attention' => 'true'
  })

owner1.save

owner2 = Owner.new({
  'first_name' => "Craig",
  'last_name' => "Morton",
  'address' => "CodeClan, Castle Terrace, Edinburgh",
  'phone_number' => '01313476521',
  'has_outside_space' => 'false',
  'has_children_at_home' => 'false',
  'has_cats' => 'true',
  'has_dogs' => 'false',
  'has_rabbits' => 'false',
  'can_give_special_attention' => 'false'
  })

owner2.save

adoption_flopsy_keith = Adoption.new({
  'owner_id' => owner1.id,
  'animal_id' => mr_flopsy.id,
  'date' => "2017/02/22"
  })

adoption_flopsy_keith.save

binding.pry
nil