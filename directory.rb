def input_students
  puts "Please enter the names of the students".center(100)
  puts "To finish, just hit return twice".center(100)
  # create an empty array
  students = []
  # get the first name
  name = gets.strip
  
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter their cohort"
    cohort = gets.strip.to_sym
    cohort.empty? ? cohort = :april : cohort
    # add the student hash to the array
    students << {name: name, cohort: cohort, hobbies: "swimming", country_of_birth: :Ireland}
    if students.length > 1
      puts "Now we have #{students.count} students"
    else
      puts "Now we have #{students.count} student"
    end
    # get another name from the user
    name = gets.strip
  end
  # return the array of students
  students
end 

def print_header
  puts "The students of Villains Academy".center(100)
  puts "-------------".center(100)
end

# def print(students)
#   count = 1
#   while count == 1
#     students.each { |student| 
#       puts "#{student[:name]}"
#       }
#     count += 1
#   end
# end

def print(students)
# students.each_with_index { |student, index| 
  # if student[:name].chars.first == "A" && student[:name].length < 12
    # puts "#{index+1}) #{student[:name]} (#{student[:cohort]} cohort). loves #{student[:hobbies]}, born in #{student[:country_of_birth]}".center(100)
  # end
# }
  puts "Enter cohort to group people by"
  category = gets.strip.to_sym

  favourite = {}

  students.each { |element|
    element.each { |k, v|
      if v == category
        favourite[v] ||= []
        favourite[v] << element[:name]
      end
    }
  }

  puts favourite[category].flatten
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(100)
end

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
    end
  end
end

# nothing happens until we call the methods
# students = input_students
# print_header
# print(students)
# print_footer(students)

interactive_menu