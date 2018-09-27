require_relative("../db/sql_runner")

class Role

  attr_accessor :movie_id, :actor_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id']
    @actor_id = options['actor_id']
    @fee = options['fee']
  end

  def save()
    sql = "INSERT INTO roles(
    movie_id,
    actor_id,
    fee
      )

    VALUES (
      $1, $2, $3
    )
    RETURNING id"
    values = [@movie_id, @actor_id, @fee]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM roles"
    values = []
    roles = SqlRunner.run(sql, values)
    result = roles.map { |role| Role.new( role ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM roles"
    values = []
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE roles SET
    movie_id   = $1,
    actor_id  = $2,
    fee       = $3,
    WHERE id  = $4"
    values = [@movie_id, @actor_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

end
