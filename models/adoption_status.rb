class AdoptionStatus

  attr_reader :id, :status

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @status = options['status']
  end

  def save()
    sql ="INSERT INTO adoption_statuses (status) VALUES ('#{@status}') RETURNING *; "
    status_hash = SqlRunner.run(sql).first
    @id = status_hash['id'].to_i
  end

  def self.find_by_status(status_desc)
    sql = "SELECT * FROM adoption_statuses WHERE status = '#{status_desc}';"
    status_hash = SqlRunner.run(sql).first
    status = AdoptionStatus.new(status_hash)
    return status
  end


  def self.delete_all()
    sql = "DELETE FROM adoption_statuses;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM adoption_statuses;"
    status_hashes = SqlRunner.run(sql)
    status_objects = status_hashes.map {|status| AdoptionStatus.new(status)}
    return status_objects
  end

end