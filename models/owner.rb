class Owner

  attr_reader :id, :first_name, :last_name, :address, :phone_number

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @address = options['address']
    @phone_number = options['phone_number']
  end

  def save()
    sql = "INSERT INTO owners (first_name, last_name, address, phone_number) VALUES ('#{@first_name}', '#{@last_name}', '#{@address}', #{@phone_number}) RETURNING *"
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