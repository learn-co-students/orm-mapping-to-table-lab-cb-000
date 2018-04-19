class Student
  attr_accessor :name, :grade
  attr_reader :id

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def save
    DB[:conn].execute("INSERT INTO students (name, grade) VALUES (?, ?)", @name, @grade)
    @id = DB[:conn].execute("SELECT id FROM students WHERE name = (?)", @name)[0][0]
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    return student
  end

end
