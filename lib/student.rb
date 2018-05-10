class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  # sql =  <<-SQL 
  #   CREATE TABLE IF NOT EXISTS songs (
  #     id INTEGER PRIMARY KEY, 
  #     name TEXT, 
  #     album TEXT
  #     )
  #     SQL
  # DB[:conn].execute(sql) 
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
end
