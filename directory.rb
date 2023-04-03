require 'csv'

@students = []
@cohort = :november

def load_students_on_open
  filename = "students.csv"
  if File.exist?(filename)
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
  else
    return if filename.nil?
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students(filename)
  CSV.foreach(filename) { |row|
    name, cohort = row
    add_student(name, cohort)
  }
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit" 
end

def process(selection)
  case selection
  when "1"
    input_students
    puts "Input successful!"
  when "2"
    show_students
    puts "Showing students successful!"
  when "3"
    save_students
    puts "Save successful!"
  when "4"
    puts "Enter the name and extension of the file you'd like to load"
    file = gets.chomp
    if File.exist?(file)
      load_students(file)
      puts "Load successful!"
    else
      puts "Sorry, #{file} doesn't exist"
    end
  when "9"
    exit 
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  
  while !name.empty? do
    add_student(name, @cohort)
    if @students.count > 1
      puts "Now we have #{@students.count} students"
    else
      puts "Now we have #{@students.count} student"
    end

    name = STDIN.gets.chomp
  end

end

def show_students
  puts "The students of Villains Academy"
  puts "-------------"
  
  print_student_list
  
  puts "Overall, we have #{@students.first.count} great students"
end

def print_student_list
  @students.each { |element|
    puts "#{element[:name]} (#{element[:cohort]} cohort)"
  }
end

def save_students
  puts "Please enter the name and extension of the file you'd like to save as"
  file_name = gets.chomp
  if File.exist?(file_name)
    CSV.open("#{file_name}", "w") { |row|
      @students.each { |student|
        row << [student[:name], student[:cohort]]
      }
    }
  else
    file = File.open("students.csv", "w")
    @students.each { |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
  }
  end
end

load_students_on_open
interactive_menu