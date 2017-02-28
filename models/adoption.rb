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

  def finalise_adoption(animal_id, owner_id)
    animal = Animal.find(animal_id)
    owner = Owner.find(owner_id)
    animal.process_adoption
    owner.update_animals_at_home(animal.get_type)

  end

  def self.delete_all
    sql = "DELETE FROM adoptions;"
    SqlRunner.run(sql)
  end

  def self.weekly_adoptions
    today = Date.today
    week_ago = (today - 7)
    sql = "SELECT * FROM adoptions WHERE date BETWEEN '#{week_ago}' AND '#{today}'"
    adoptions_hashes = SqlRunner.run(sql)
    number_of_adoptions = adoptions_hashes.count
    return number_of_adoptions
  end


end