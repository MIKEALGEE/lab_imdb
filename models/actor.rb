require_relative("../db/sql_runner")

class Actor

    attr_accessor :first_name, :last_name
    attr_reader :id

    def initialize(options)
      @id = options['id'].to_i if options['id']
      @first_name = options['first_name']
      @last_name = options['last_name']
    end


    def save()
      sql = "INSERT INTO actors(
       first_name,
       last_name )

      VALUES (
        $1 , $2
      )
      RETURNING id"
      values = [@first_name, @last_name]
      @id = SqlRunner.run(sql,values)[0]["id"].to_i
    end


      def self.all()
        sql = "SELECT * FROM actors"
        values = []
        actors = SqlRunner.run(sql, values)
        result = actors.map { |actor| Actor.new( actor ) }
        return result
      end

      def self.delete_all()
        sql = "DELETE FROM actors"
        values = []
        SqlRunner.run(sql, values)
      end

      def update
        sql = "UPDATE actors SET first_name = $1, last_name = $2 WHERE id = $3"
        values = [@first_name, @last_name, @id]
        SqlRunner.run(sql, values)
      end

      def actors_in_movies
        sql = "SELECT * FROM movies
        INNER JOIN roles
        ON roles.movie_id = movies.id
        WHERE roles.actor_id = $1;"
        results = SqlRunner.run(sql, [@id])
        hash = results.map do |order_hash|
        Movie.new(order_hash)
      end
      end
end
