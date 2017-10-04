require("pry")
require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'name' => 'Kanye West'
  })

artist2 = Artist.new({
  'name' => 'The Weeknd'
  })
artist3 = Artist.new({
  'name' => 'Jay Z'
  })

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new({
  'title' => 'The Life of Pablo',
  'genre' => 'Hip Hop',
  'artist_id' => artist1.id
  })

album2 = Album.new({
    'title' => 'Starboy',
    'genre' => 'Hip Hop',
    'artist_id' => artist2.id
    })
album3 = Album.new({
    'title' => 'The Blueprint',
    'genre' => 'Hip Hop',
    'artist_id' => artist3.id
    })
album4 = Album.new({
    'title' => 'Late Registration',
    'genre' => 'Hip Hop',
    'artist_id' => artist1.id
    })

album1.save()
album2.save()
album3.save()
album4.save()


binding.pry
nil
