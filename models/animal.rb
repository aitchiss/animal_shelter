class Animal

  attr_reader :id, :adoption_status_id, :photo_file_path, :breed, :type_id, :admission_date, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @admission_date = options['admission_date']
    @type_id = options['type_id'].to_i
    @breed = options['breed']
    @adoption_status_id = options['adoption_status_id'].to_i
    @photo_file_path = options['photo_file_path']
  end

  def save()
    sql = "INSERT INTO animals 
          (name, admission_date, type_id, breed, 
          adoption_status_id, photo_file_path) 
          VALUES ('#{@name}', '#{@admission_date}', #{@type_id}, '#{@breed}', 
          #{@adoption_status_id}, '#{@photo_file_path}') 
          RETURNING * ;"

    animal_hash = SqlRunner.run(sql).first
    @id = animal_hash['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM animals;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM animals;"
    Animal.get_many(sql)
  end

  def self.get_many(sql)
    animals_info = SqlRunner.run(sql)
    animals = animals_info.map {|animal| Animal.new(animal)}
    return animals
  end



end