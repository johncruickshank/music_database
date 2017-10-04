require_relative "../db/sqlrunner"

class Artist
  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql, "save_artist", values)[0]['id'].to_i()
  end

  def self.list_all()
    sql = "SELECT * FROM artists"
    values = []
    result = SqlRunner.run(sql, "list_artists", values)
    return result.map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    values = []
    SqlRunner.run(sql, "delete_artists", values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_artist", values)
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, "get_albums", values)
    albums = results.map {|album| Album.new(album)}
    return albums
  end

  def update()
    sql = "UPDATE artists SET (name) = ($1) WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, "update_artist", values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql, "update_artists", values)[0]
    result = Artist.new(artist)
  end







end
