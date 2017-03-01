class Owner

  attr_reader :id

  attr_accessor :first_name, :last_name, :address, :phone_number, :has_outside_space, :has_children_at_home, :has_cats, :has_dogs, :has_rabbits, :can_give_special_attention

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
    @phone_number = options['phone_number']
    @has_outside_space = options['has_outside_space']
    @has_children_at_home = options['has_children_at_home']
    @has_cats = options['has_cats']
    @has_dogs = options['has_dogs']
    @has_rabbits = options['has_rabbits']
    @can_give_special_attention = options['can_give_special_attention']
  end

  def save()
    sql = "INSERT INTO owners 
    (first_name, 
    last_name, 
    address, 
    phone_number,
    has_outside_space,
    has_children_at_home,
    has_cats,
    has_dogs,
    has_rabbits,
    can_give_special_attention) 
    VALUES 
    ('#{@first_name}', 
    '#{@last_name}', 
    '#{@address}', 
    #{@phone_number},
    '#{@has_outside_space}',
    '#{@has_children_at_home}',
    '#{@has_cats}',
    '#{@has_dogs}',
    '#{@has_rabbits}',
    '#{@can_give_special_attention}') 
    RETURNING *"
    owner_hash = SqlRunner.run(sql).first
    @id = owner_hash['id'].to_i
  end

  def animals()
    sql = "SELECT a.* FROM animals a INNER JOIN
            adoptions ad ON ad.animal_id = a.id
            WHERE ad.owner_id = #{@id};"
    animals = Animal.get_many(sql)
    return animals
  end

  def update()
    sql = "UPDATE owners SET 
    (first_name, 
    last_name, 
    address, 
    phone_number,
    has_outside_space,
    has_children_at_home,
    has_cats,
    has_dogs,
    has_rabbits,
    can_give_special_attention) = 
    ('#{@first_name}', 
    '#{@last_name}', 
    '#{@address}', 
    '#{@phone_number}',
    '#{@has_outside_space}',
    '#{@has_children_at_home}',
    '#{@has_cats}',
    '#{@has_dogs}',
    '#{@has_rabbits}',
    '#{@can_give_special_attention}') 
    WHERE id = #{@id} "
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM owners WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def has_enough_space(animal_id)
    animal = Animal.find(animal_id)
    return false if animal.needs_outside_space == "t" && @has_outside_space == "f"
    return true
  end

  def suitable_animals_at_home(animal_id)
    animal = Animal.find(animal_id)
    animal_type = animal.get_type

    case animal_type

    when "cat"
        return false if animal.can_live_with_same_type == "f" && @has_cats == "t"
        if animal.can_live_with_other_type == "f" 
            return false if @has_dogs == "t"
            return false if @has_rabbits == "t"
        end
        return true

    when "dog"
        return false if animal.can_live_with_same_type == "f" && @has_dogs == "t"
        if animal.can_live_with_other_type == "f" 
            return false if @has_cats == "t"
            return false if @has_rabbits == "t"
        end
        return true

    when "rabbit"
        return false if animal.can_live_with_same_type == "f" && @has_rabbits == "t"
        if animal.can_live_with_other_type == "f" 
            return false if @has_dogs == "t"
            return false if @has_cats == "t"
        end
        return true
    end
  end


  def family_suitable_for_animal(animal_id)
    animal = Animal.find(animal_id)
    return false if animal.can_live_with_children == "f" && @has_children_at_home == "t"
    return true
  end

  def can_give_correct_attention(animal_id)
    animal = Animal.find(animal_id)
    return false if animal.needs_special_attention == "t" && @can_give_special_attention == "f"
    return true
  end


  def match(animal_id)
    suitabilities = []

    suitabilities << has_enough_space(animal_id)
    suitabilities << suitable_animals_at_home(animal_id)
    suitabilities << family_suitable_for_animal(animal_id)
    suitabilities << can_give_correct_attention(animal_id)

    return false if suitabilities.include?(false)
    return true
  end  

  def all_adoptable_matches()
    animals = Animal.all
    matched_animals = []
    animals.each do |animal|
        if self.match(animal.id) == true && animal.get_adoption_status == "ready for adoption"
            matched_animals << animal
        end
    end
    return matched_animals
  end

  def update_animals_at_home(type)
    if type == "dog"
        @has_dogs = 'true'
    elsif type == "cat"
        @has_cats = 'true'
    elsif type == "rabbit"
        @has_rabbits = 'true'
    end

    self.update
  end

  def self.delete_all()
    sql = "DELETE FROM owners;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM owners;"
    owners_hashes = SqlRunner.run(sql)
    owners = owners_hashes.map {|owner| Owner.new(owner)}
    return owners
  end

  def self.find(id)
    sql="SELECT * FROM owners WHERE id=#{id};"
    owner_hash = SqlRunner.run(sql).first
    owner = Owner.new(owner_hash)
    return owner
  end


end