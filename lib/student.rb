class Student

  TABLE_NAME = "students"

  class << self
    def create_table()
      DB[:conn].execute("CREATE TABLE IF NOT EXISTS #{TABLE_NAME} " +
                            "(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)")
    end

    def drop_table()
      DB[:conn].execute("DROP TABLE IF EXISTS #{TABLE_NAME};")
    end

    def create(attributes)
      return Student.new().set_attributes(attributes).save
    end
  end

  attr_accessor :name, :grade
  attr_reader :id

#  def initialize(attributes)
#    attributes.each { |key, value| self.send(("#{key}="), value) }
#  end
  def initialize(name=nil, grade=nil)
    self.name = name
    self.grade = grade
  end

  def set_attributes(attributes)
    attributes.each { |key, value| self.send(("#{key}="), value) }
    return self
  end

  def save()
    sql = "INSERT INTO #{TABLE_NAME} (name, grade) VALUES (?, ?)"

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{TABLE_NAME}")[0][0]

    return self
  end

end
