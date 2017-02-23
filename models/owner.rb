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

  def self.delete_all
    sql = "DELETE FROM owners;"
    SqlRunner.run(sql)
  end


end