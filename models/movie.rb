require_relative("../db/sql_runner")

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @id  = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
  end


  def save()
    sql = "INSERT INTO movies(
     title,
     genre )

    VALUES (
      $1 , $2
    )
    RETURNING id"
    values = [@title, @genre]
    @id = SqlRunner.run(sql,values)[0]["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    result = movies.map { |movie| Movie.new( movie ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

  def update
    sql = "UPDATE movies SET title = $1, genre = $2 WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def actors_in_movies
    sql = "SELECT * FROM actors
    INNER JOIN roles
    ON roles.actor_id = actors.id
    WHERE roles.movie_id = $1;"
    results = SqlRunner.run(sql, [@id])
    hash = results.map do |order_hash|
    Actor.new(order_hash)
  end 
  end

end
