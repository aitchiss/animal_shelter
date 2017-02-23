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

end