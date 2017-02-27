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
    if animal.needs_outside_space == "t" && @has_outside_space == "false"
        return false
    end
    return true
  end



  # def match(animal_id)
  #   animal = Animal.find(animal_id)
  #   animal_type = animal.get_type

  #   if animal_type == "cat"
  #       return false if animal.can_live_with_same_type == "false" && @has_cats == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_dogs == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_rabbits == "true"

  #   elsif animal_type == "dog"
  #       return false if animal.can_live_with_same_type == "false" && @has_dogs == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_cats == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_rabbits == "true"

  #   elsif animal_type == "rabbit"
  #       return false if animal.can_live_with_same_type == "false" && @has_rabbits == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_dogs == "true"
  #       return false if animal.can_live_with_other_type == "false" && @has_cats == "true"

  #   end

  #   if animal.needs_outside_space == "true" && @has_outside_space == "false"
  #       return false
  #   end

  #   return false if animal.can_live_with_children == "false" && @has_children_at_home == "true"

  #   return false if animal.needs_special_attention == "true" && @can_give_special_attention == "false"

  #   return true
  # end  


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