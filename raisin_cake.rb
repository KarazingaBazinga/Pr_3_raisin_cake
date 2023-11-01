def cut_cake(cake, pieces, n, m)
  m.each do |mult|
    # потенційно можливі шматочки пиріга
    # координати за вертикаллю, координати за горизонталлю
    potential_pieces = []
    # потенційно можливі горизонтальні частинки шматочків пирога
    # [строка, початок, кінець, родзинка є чи ні]
    potential_horizontals = []
    a = mult[0] # необхідна послідовна кількість найменших
    # частинок пиріга на кожній горизонталі
    b = mult[1] # необхідна послідовна кількість найменших
    # частинок пиріга на кожній вертикалі

    cake.each_with_index do |row, row_index|
      raisin = 0 # кількість родзинок у горизонатльній частині шматочка
      raisin_index = -1 # індекс родзиники у масиві
      a_c = 0 # лічильник доступних найменших частинок пиріга за горизонталлю(доступних елементів масиву)

      row.each_with_index do |element, col_index|
        # Перевірка чи не є частинка відрізаємого шматочка у вже відрізаному шматочку
        pieces.each do |piece|
          if (row_index >= piece[0]) && (row_index <= piece[1]) && (col_index >= piece[2]) && (col_index <= piece[3])
            a_c = -1 # якщо частинка є у відрізаному шматочку послідовність приривається
            break
          end
        end

        if a_c == -1
          a_c = 0
          raisin = 0
          next
        end

        if element == "o"
          raisin += 1
          raisin_index = col_index
        end
        if raisin > 1
          raisin = 1
          a_c = 1
          next
        end
        a_c += 1

        if (a_c == a) && ((raisin_index >= col_index - a + 1) && (raisin_index <= col_index))
          potential_horizontals.push([row_index, col_index - a + 1, col_index, 1]) # строка, початок, кінець, родзинка є чи ні
          a_c -= 1
        elsif a_c == a
          potential_horizontals.push([row_index, col_index - a + 1, col_index, 0] ) # строка, початок,
          # кінець, родзинка є чи ні
          a_c -= 1
          raisin = 0
        end

      end

    end

    potential_horizontals.each_with_index do |x, x_index|
      raisin = 0 # скільки родзинок у потенційному повному шматочку
      vert_horizontals = 0 # показує скільки горизонтальних частин збігається по вертикалі

      potential_horizontals[x_index..-1].each do |y|
        if (vert_horizontals == b) || (y[0] > x[0] + vert_horizontals) # умова для відміни зайвих ітерацій
          break
        elsif (y[0] == x[0] + vert_horizontals) && (y[1] == x[1]) && (y[2] == x[2])
          vert_horizontals += 1
          if y[3] == 1
            raisin += 1
          end
        end
      end

      if (raisin == 1) && (vert_horizontals == b)
        potential_pieces.push([x[0], x[0] + b - 1, x[1], x[2]]) # координати за вертикаллю,
        # координати за горизонталлю
      end
    end

    potential_pieces.each do |piece|
      pieces.push(piece)
      if n == 1
        return pieces
      end

      pieces = cut_cake(cake, pieces, n - 1, m)
      if pieces[-1] == [-1, -1, -1, -1]
        pieces.pop
        pieces.pop
      else
        return pieces
      end
    end

  end
  pieces.push([-1, -1, -1, -1])
  pieces
end

def cake_input
  x = 0
  while true
    puts "Введіть розмір пиріга по вертикалі:"
    x = gets.to_i
    if x <= 0
      puts "Некорректні дані. Повторіть, будь ласка"
    else
      break
    end
  end

  y = 0
  while true
    puts "Введіть розмір пиріга по горизонталі:"
    y = gets.to_i
    if y <= 0
      puts "Некорректні дані. Повторіть, будь ласка"
    else
      break
    end
  end

  cake = []
  for a in 0..(x-1)

    puts "Горизонтальний шматочок #{a+1}"
    h_piece_input = gets.chomp
    h_piece = h_piece_input.split("")
    if h_piece.size != y
      puts "Невірний розмір. Повторіть!"
      redo
    end

    flag = 0
    for b in 0..(y-1)
      if h_piece[b] != "o" && h_piece[b] != "."
        flag = -1
        break
      end
    end

    if flag == -1
      puts "Невірні символи. Повторіть!"
      redo
    end

    cake[a] = h_piece
  end

  cake
end

def raisin_count(cake)
  n = 0
  cake.each do |part|
    part.each do |element|
      if element == "o"
        n += 1
      end
    end
  end
  n
end

def multipliers(num)
  m = []
  for a in num.downto(1)
    for b in 1..num
      if a * b == num
        m.push([a, b])
      end
    end
  end
  m
end

def print_cake(cake, pieces)
  if pieces[0] == [-1, -1, -1, -1]
    puts "Неможливо поділити пиріг"
  end

  #Сортування пиріга
  sorted_pieces = []
  for i in 0..(cake[0].size-1)
    for z in 0..(cake.size)
      pieces.each do |part|
        if part[2] == i && part[0] == z
          sorted_pieces.push(part)
          pieces.delete(part)
        end
      end
    end
  end

  # вивід пиріга на екран
  puts "["
  sorted_pieces.each_with_index  do |part, part_index|
    for i in part[0]..part[1]
      print " "
      for z in part[2]..part[3]
        print cake[i][z]
      end
      if i == part[0]
        print " // шматочок #{part_index + 1}"
      end
      print "\n"
    end
    if part_index < sorted_pieces.size - 1
      puts ","
    end
  end
  puts "]"

end

