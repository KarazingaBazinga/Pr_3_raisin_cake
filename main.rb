require_relative "raisin_cake"
puts "=== Меню ==="
while true
  puts "1. Приклад 1"
  puts "2. Приклад 2"
  puts "3. Приклад 3"
  puts "4. Свій приклад"
  puts "5. Вихід"
  choice = gets.to_i
  case choice
  when 1
  puts "Приклад 1"
  cake = [["o","o",".",".","o","."], [".",".",".",".","o","."], [".",".","o",".",".","o"]]
  cake.each do |part|
    puts part.join(' ')
  end
  pieces = cut_cake(cake, [], 6, [[3,1], [1,3]])
  print_cake(cake, pieces)
  when 2
  puts "Приклад 2"
  cake = [["o","o",".",".","o","."], [".",".",".",".","o","."], [".",".",".",".",".","."], [".", ".", "o", ".", "o", "."]]
  cake.each do |part|
    puts part.join(' ')
  end
  pieces = cut_cake(cake, [], 6, [[4,1], [2,2], [1,4]])
  print_cake(cake, pieces)
  when 3
  puts "Приклад 3"
  cake = [["o","o",".",".","o",".", "."], [".",".",".",".","o",".","o"], [".",".",".",".",".",".", "."], [".", ".", "o", ".", "o", ".", "."]]
  cake.each do |part|
    puts part.join(' ')
  end
  pieces = cut_cake(cake, [], 7, [[4,1], [2,2], [1,4]])
  print_cake(cake, pieces)
  when 4
    puts "Ваш приклад:"
    cake = cake_input
    puts "Ваш пиріг:"
    cake.each do |part|
      puts part.join(' ')
    end
    n = raisin_count(cake)
    if (cake.size * cake[0].size) % n != 0
      puts "Пиріг неможливо поділити!"
    else
      m = multipliers((cake.size * cake[0].size) / n)
      pieces = cut_cake(cake, [], n, m)
      print_cake(cake, pieces)
    end
  when 5
  puts "Вихід із програми."
  break
  else
  puts "Невірний вибір. Будь ласка, оберіть знову"
  end
end

