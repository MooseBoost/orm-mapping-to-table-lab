class Student
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(name, grade, id=nil)
    
    @name = name
    @grade = grade
    @id = id
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE
        students(
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade TEXT
        );
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE
      students;
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def save
    
    sql = <<-SQL
      INSERT INTO
        students (name, grade)
      VALUES
        (?, ?);
    SQL
    
    DB[:conn].execute(sql, @name, @grade)
    
    sql = <<-SQL
      SELECT id
      FROM students
      ORDER BY id
      DESC
      LIMIT 1;
    SQL
    
    @id = DB[:conn].execute(sql)[0][0]
    
    return self
  end
  
  def self.create(student)
    student = Student.new(student[:name], student[:grade])
    student.save
  end
    
  
end
