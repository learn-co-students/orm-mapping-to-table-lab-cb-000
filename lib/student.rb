class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @id = id
    @name = name
    @grade = grade
  end

  # Creates students table in the database
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql)
  end

  # Drops students table from the database
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, name, grade)

    @id = DB[:conn].execute('SELECT max(id) FROM students')[0][0]
  end

  def self.create(attributes)
    student = Student.new(attributes[:name], attributes[:grade])
    student.save
    student
  end
end
