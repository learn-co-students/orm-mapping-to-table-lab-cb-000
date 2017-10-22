class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name,
        grade
      );
    SQL
    DB[:conn].execute(sql)
    # update later to pass in name and grade from instance
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) VALUES (?, ?);
    SQL
    DB[:conn].execute(sql, self.name, self.grade)
    #@id = DB[:conn].execute("SELECT last_inserted_row[0][0]")
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    newby = Student.new(name, grade)
    newby.save
    newby
  end

end
