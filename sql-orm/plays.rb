require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    #data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def Play::find_by_title(title)
    PlayDBConnection.instance.execute(<<-SQL, title)
    SELECT * FROM plays WHERE plays.title = ?
    SQL
  end

  def Play::find_by_playwright(name)
    PlayDBConnection.instance.execute(<<-SQL, name)
    SELECT * FROM playwrights WHERE playwrights.name = ?
    SQL
  end
end

class Playwright
  attr_accessor :id, :name, :birth_year
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * from playwrights")
    #data.map {|datum| Playwright.new(datum)}
  end
  
  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def Playwright::find_by_name(name)
    PlayDBConnection.instance.execute(<<-SQL, name)
    SELECT * FROM playwrights WHERE playwrights.name = ?
    SQL
  end

  def create
    raise "#{self} already in db" if self.id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year)
    INSERT INTO playwrights (name, birth_year)
    VALUES (?,?)
    
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in db" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, @name, @birth_year, @id)
    UPDATE playwrights
    SET name = ?, birth_year = ?
    WHERE
    id = ?
    SQL
  end

  def get_plays
    PlayDBConnection.instance.execute(<<-SQL, @id)
    SELECT title
    FROM playwrights
    JOIN plays ON playwrights.id = plays.playwright_id
    WHERE playwrights.id = ?
    SQL
  end
end

arthurmiller = Playwright.new({"id"=>4,"name"=>"Mike Jackson", "birth_year"=>1975})

p arthurmiller.id
arthurmiller.update

puts Playwright.all