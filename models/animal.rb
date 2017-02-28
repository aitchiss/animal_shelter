class Animal

  attr_reader :id, :adoption_status_id,  :type_id

  attr_accessor :photo_file_path, :breed, :name, :admission_date, :needs_outside_space, :can_live_with_children, :can_live_with_same_type, :can_live_with_other_type, :needs_special_attention

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @admission_date = options['admission_date']
    @type_id = options['type_id'].to_i
    @breed = options['breed']
    @adoption_status_id = options['adoption_status_id'].to_i
    @photo_file_path = options['photo_file_path']
    @needs_outside_space = options['needs_outside_space']
    @can_live_with_children = options['can_live_with_children']
    @can_live_with_same_type = options['can_live_with_same_type']
    @can_live_with_other_type = options['can_live_with_other_type']
    @needs_special_attention = options['needs_special_attention']
  end

  def save()
    sql = "INSERT INTO animals 
          (name, 
          admission_date, 
          type_id, 
          breed, 
          adoption_status_id, 
          photo_file_path,
          needs_outside_space,
          can_live_with_children,
          can_live_with_same_type, 
          can_live_with_other_type, 
          needs_special_attention) 
          VALUES 
          ('#{@name}', 
          '#{@admission_date}', 
          #{@type_id}, 
          '#{@breed}', 
          #{@adoption_status_id}, 
          '#{@photo_file_path}', 
          '#{@needs_outside_space}',
          '#{@can_live_with_children}', 
          '#{@can_live_with_same_type}', 
          '#{@can_live_with_other_type}', 
          '#{@needs_special_attention}') 
          RETURNING * ;"

    animal_hash = SqlRunner.run(sql).first
    @id = animal_hash['id'].to_i
  end

  def admission_date_formatted()
    return pretty_date(@admission_date)
  end

  def pretty_date(date)
    if date.include?('-')
      date_components = date.split('-')
      date_components.reverse!
      date = date_components.join('/')
      return date
    else
      date_components = date.split('/')
      date_components.reverse!
      date = date_components.join('/')
      return date
    end
  end

  def update()
    sql = "UPDATE animals SET 
        (name, 
        admission_date, 
        type_id, 
        breed, 
        adoption_status_id, 
        photo_file_path,
        needs_outside_space,
        can_live_with_children,
        can_live_with_same_type, 
        can_live_with_other_type, 
        needs_special_attention) = 
        ('#{@name}', 
        '#{@admission_date}', 
        #{@type_id}, 
        '#{@breed}', 
        #{@adoption_status_id}, 
        '#{@photo_file_path}',
        '#{@needs_outside_space}',
        '#{@can_live_with_children}', 
        '#{@can_live_with_same_type}', 
        '#{@can_live_with_other_type}', 
        '#{@needs_special_attention}') 
        WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def get_adoption_status
    sql = "SELECT * FROM adoption_statuses WHERE id = #{@adoption_status_id};"
    statuses_hash = SqlRunner.run(sql).first
    status_object = AdoptionStatus.new(statuses_hash)
    return status_object.status
  end

  def get_adoption_date
    sql = "SELECT * FROM adoptions WHERE animal_id = #{@id};"
    adoption_hash = SqlRunner.run(sql).first
    adoption = Adoption.new(adoption_hash)
    return pretty_date(adoption.date)
  end

  def get_type
    sql= "SELECT * FROM animal_types WHERE id = #{@type_id};"
    type_hash = SqlRunner.run(sql).first
    animal_type = AnimalType.new(type_hash)
    return animal_type.type
  end

  def owner
    sql = "SELECT owners.* FROM owners INNER JOIN adoptions ON adoptions.owner_id = owners.id WHERE adoptions.animal_id = #{@id} ;"
    owner_hash = SqlRunner.run(sql).first
    owner = Owner.new(owner_hash)
    return owner
  end

  def change_adoption_status(status_id)
    @adoption_status_id = status_id
  end

  def process_adoption()
    adoption_status = AdoptionStatus.find_by_status('adopted')
    @adoption_status_id = adoption_status.id
    self.update
  end

  def owner_matches()
    owners = Owner.all
    matched_owners = []
    owners.each do |owner|
      if owner.match(@id)
        matched_owners << owner
      end
    end

    return matched_owners
  end

  def delete()
    sql = "DELETE FROM animals WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM animals;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM animals;"
    Animal.get_many(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM animals WHERE id = #{id};"
    animal_hash = SqlRunner.run(sql).first
    return Animal.new(animal_hash)
  end

  def self.get_many(sql)
    animals_info = SqlRunner.run(sql)
    animals = animals_info.map {|animal| Animal.new(animal)}
    return animals
  end

  def self.get_all_adoptable
    sql = "SELECT animals.* FROM animals INNER JOIN adoption_statuses ON adoption_statuses.id = animals.adoption_status_id WHERE adoption_statuses.status = 'ready for adoption' "
    animals = Animal.get_many(sql)
    return animals

  end



  def self.count_need_adoption
    animals = Animal.all
    count = 0
    animals.each do |animal|
      count += 1 if animal.get_adoption_status == "ready for adoption"
    end
    return count
  end

  def self.count_in_care
    animals = Animal.all
    count = 0
    animals.each do |animal|
      count += 1 if animal.get_adoption_status != "adopted"
    end

    return count
  end

  def self.get_by_type(id)
    sql = "SELECT * FROM animals WHERE type_id = #{id};"
    animals = Animal.get_many(sql)
    return animals
  end

  def self.search_for_breed(type_id, keyword)
    all_of_type = Animal.get_by_type(type_id)
    matches = []
    all_of_type.each do |animal|
      if animal.breed.downcase.include?(keyword.downcase)
        matches << animal
      end
    end

    return matches

  end





end