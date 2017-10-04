require 'pg'

class SqlRunner

  def self.run(sql, tag, values)
    db = PG.connect({dbname: 'music', host: 'localhost'})
    db.prepare(tag, sql)
    result = db.exec_prepared(tag, values)
    db.close()
    return result if result
  end

end
