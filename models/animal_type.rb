class AnimalType

  attr_reader :type, :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @type = options['type']
  end


  def save()
    sql = "INSERT INTO animal_types (type) VALUES ('#{@type}') RETURNING * ;"
    animal_type_hash = SqlRunner.run(sql).first
    @id = animal_type_hash['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM animal_types;"
    SqlRunner.run(sql)
  end

  def self.find(search_id)
    sql = "SELECT * FROM animal_types WHERE id = #{search_id};"
    type_hash = SqlRunner.run(sql).first
    return AnimalType.new(type_hash)
  end

  def self.all()
    sql = "SELECT * FROM animal_types;"
    animal_type_hashes = SqlRunner.run(sql)
    animal_types = animal_type_hashes.map {|type| AnimalType.new(type)}
    return animal_types
  end

end