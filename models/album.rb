require_relative "artist"
require_relative "../db/sqlrunner"

class Album
  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i()
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, "save_album", values)
    @id = result[0]['id'].to_i()
  end

  def self.list_all()
    sql = "SELECT * FROM albums"
    values = []
    result = SqlRunner.run(sql, "list_albums", values)
    return result.map {|album| Album.new(album)}
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    values = []
    SqlRunner.run(sql, "delete_albums", values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, "delete_album", values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, "get_artists", values)
    artist = results.map {|artist| Artist.new(artist)}
    return artist
  end

  def update()
    sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4;"
    values = [@title, @genre, @artist_id, @id]
    SqlRunner.run(sql, "update_album", values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album = SqlRunner.run(sql, "update_album", values)[0]
    result = Album.new(album)
  end





end
