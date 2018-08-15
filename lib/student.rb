class Student
  attr_accessor :name, :grade
  attr_reader :id
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    ins = DB[:conn].prepare(<<-SQL
      CREATE TABLE students (id INTEGER PRIMARY KEY,
                               name TEXT,
                               grade INTEGER)
    SQL
    )
    ins.execute
  end
  
  def self.drop_table
    sql = DB[:conn].prepare("DROP TABLE students")
    sql.execute
  end
  
  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?) "
    DB[:conn].execute(sql, @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    
  end
  
  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end
  
end 
