class Adoption

  attr_reader :id, :owner_id, :animal_id, :date

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @owner_id = options['owner_id'].to_i
    @animal_id = options['animal_id'].to_i
    @date = options['date']
  end

  def save()
    sql = "INSERT INTO adoptions (owner_id, animal_id, date) VALUES (#{@owner_id}, #{@animal_id}, '#{@date}') RETURNING * ;"
    adoption_hash = SqlRunner.run(sql).first
    @id = adoption_hash['id'].to_i

  end

  def self.delete_all
    sql = "DELETE FROM adoptions;"
    SqlRunner.run(sql)
  end

end