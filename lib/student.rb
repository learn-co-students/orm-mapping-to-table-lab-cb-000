class Student

	attr_accessor :name, :grade;
	attr_reader :id;

	def self.create_table()
		DB[:conn].execute("CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT)");
	end

	def self.drop_table()
		DB[:conn].execute("DROP TABLE students");
	end

	def self.create(hash)
		self.new(hash[:name], hash[:grade]).tap { |student| student.save }
	end

	def initialize(name, grade, id=nil)
		@name = name;
		@grade = grade;
		@id = id;
	end

	def save()
		DB[:conn].execute("INSERT INTO students(name, grade) VALUES (?,?)", name, grade)
		@id = DB[:conn].execute("SELECT last_insert_rowid()").flatten.first
	end

end
