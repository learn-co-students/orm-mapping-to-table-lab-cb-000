=begin
attributes = name, grade, and id(optional)
=end
class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students
      (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    self.class.create_table
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql,@name,@grade)

    @id = DB[:conn].execute("SELECT LAST_INSERT_ROWID() FROM students")[0][0]
  end

  def self.create(name:, grade:)
     song = self.new(name, grade)
     song.save
     song
  end

end
