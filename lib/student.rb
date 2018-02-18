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
    # This is an instance method that saves the attributes describing a given student to the students table in our database
    # Create a variable, sql, and set it equal to the SQL statement that will INSERT the correct data into the table
    # Use bound parameters to pass the given student's name and grade into the SQL statement.
    # Remember that you don't need to insert a value for the id column (since it's the primary key, the id column's value will be automatically assigned in the DB)
    # At the end of the #save method, grab the ID of the last inserted row (the row you just inserted into the database), and assign it to the be the value of the @id attribute of the given instance
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # takes in a hash of attributes and uses metaprogramming to create a new student object. Then it uses the #save method to save that student to the database
  # returns the new object that it instantiated
  def create
  end

end

# Remember, you can access your database connection anywhere in this class with DB[:conn]
