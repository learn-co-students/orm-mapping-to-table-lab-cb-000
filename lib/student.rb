class Student
  # has a name and a grade
  # has an id that is readable but not writable
  attr_accessor  :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  # creates the students table in the database
    # Use a heredoc to set a variable, sql, equal to the necessary SQL statement
    # The attributes of a student (name, grade, id) should correspond to the column names that are created in the students table
    # The id column should be the primary key
    # Execute the SQL statement using the #execute method. This method is called on the object that stores the connection to the database, DB[:conn]
  def self.create_table
    sql =  <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    DB[:conn].execute(sql)
  end

  # drops the students table from the database
    # This is a class method that drops the students table
    # Create a variable sql, and set it equal to the SQL statement that drops the students table
    # Execute that statement against the database using DB[:conn].execute(sql)
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  # saves an instance of the Student class to the database
  def save
  end

  # takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database
  # returns the new object that it instantiated
  def create
  end

end

# Remember, you can access your database connection anywhere in this class with DB[:conn]
