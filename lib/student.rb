class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @nil = nil
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, name, grade)
    
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students").flatten.first
  end

  def self.create(name:, grade:, id: nil)
    new_student = self.new(name, grade, id = nil)
    new_student.save

    new_student
  end
end
