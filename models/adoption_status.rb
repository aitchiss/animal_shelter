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

  def self.delete_all()
    sql = "DELETE FROM adoption_statuses;"
    SqlRunner.run(sql)
  end

end