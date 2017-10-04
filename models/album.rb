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









end
