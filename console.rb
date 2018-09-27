require_relative( 'models/actor' )
require_relative( 'models/movie')
require_relative( 'models/role')

require( 'pry' )

Role.delete_all
Actor.delete_all
Movie.delete_all

actor1 = Actor.new({
  'first_name' => 'Robert',
  'last_name' => 'Downey'
  })
  actor1.save()

  actor2 = Actor.new({
    'first_name' => 'Chris',
    "last_name" => 'Hemsworth'
    })
    actor2.save()

  movie1 = Movie.new({
    'title' => 'Avengers 1',
    'genre' => 'action'
    })
  movie1.save()

  movie2 = Movie.new({
    'title' => 'Thor',
    'genre' => 'action'
    })
  movie2.save()

  movie3 = Movie.new({
    'title' => 'Iron Man',
    'genre' => 'romance'
    })
  movie3.save()


  role1 = Role.new({ 'actor_id' => actor1.id, 'movie_id' => movie1.id, 'fee' => '1000' })
  role1.save()
  role2 = Role.new({ 'actor_id' => actor2.id, 'movie_id' => movie1.id, 'fee' => '2000'  })
  role2.save()
  role3 = Role.new({ 'actor_id' => actor1.id, 'movie_id' => movie2.id, 'fee' => '3000'  })
  role3.save()

binding.pry
  nil
