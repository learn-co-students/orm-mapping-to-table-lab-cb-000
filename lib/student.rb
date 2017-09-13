
class Student

  attr_accessor  :name, :grade
  attr_reader :id
  
  def initialize( name , grade, id = nil)
    @id = id
    @name = name
    @grade = grade
    
  end

  def self.create_table

    sql = <<~SQL
    CREATE TABLE IF NOT EXISTS
    students (
      id INTEGER PRIMARY KEY, name TEXT, grade INTEGER
    )
    SQL
    
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def self.save(name: , grade:)
    sql = <<~SQL
    INSERT INTO students (name, grade)
    VALUES
    (?, ?)
    SQL

    DB[:conn].execute(sql, name, grade)

  end

  def save
    sql = <<~SQL
    INSERT INTO students (name, grade)
    VALUES
    (?, ?)
    SQL

    DB[:conn].execute(sql, @name, @grade)

    sql_2 = <<~SQL
    SELECT id FROM students 
    WHERE name = ?
    SQL

    @id = DB[:conn].execute(sql_2, @name).flatten[0]

  end



  def self.create(name: , grade:)

    self.save(name: name, grade: grade)

    sql = <<~SQL
    SELECT id FROM students
    WHERE
    students.name = ?
                      SQL
                      
                      id = DB[:conn].execute(sql, name).flatten[0]
                      student = Student.new(name, grade, id)
  end
  
end


