require 'awesome_print'
require 'terminal-table'

def calcBinary( dato )
  carry = []
  result = []
  dato *= 2
  while true

    if carry.include?(dato)
      break
    end
    carry.push(dato)

    if dato >= 1
      result.push( 1 )
      dato -= 1
    else
      result.push( 0 )
    end

    dato *= 2
  end

  # result.pop

  return result
end

def printDefaultDenominator( realValue, defDenominator )
  if realValue == 0
    return 0
  else
    scale = defDenominator / realValue.denominator
    return "#{realValue.numerator * scale}/#{defDenominator}"  
  end
  
end

#Cuantos eventos estan participando
#cambiar mensajes de entrada
#que no acepte caracteres, ni numeros, ni negativos, solo fracciones y decimales

while true
  puts "Ingrese los datos separados por comas"
  array = gets.chomp.split(",") #.map{|x| x.to_r }

  begin
    datas = array.map{|x| x.to_r }
  rescue Exception => e
    puts "Valores no validos"
    puts ""
    next
  end
  
  paso = true
  array.each do |arr|

    thisarr = arr.to_r
    if thisarr <= 0 || thisarr > 1
      puts "El valor #{ arr } es incorrecto"
      paso = false
    end
  end

  if datas.inject{|sum, x| sum + x } == 1

    if paso
      break
    else
      puts "Datos incorrectos"
      puts ""
    end
    
  else
    puts "Los datos no suman 1"
    puts ""
  end
end


maxDenominator = datas.map{|x| x.denominator }.reduce(1, :lcm)
# datas = "3/9,3/9,1/9,1/9,1/9".split(",").map{|x| x.to_r }

table1 = []
countTable = 1
sum = 0
binaryData = []
lk = []

datas.each_with_index do |data, i|

  if i == 0
    thisBinary = [0]
  else
    thisBinary = calcBinary( sum )  
  end
  binaryData.push( thisBinary )

  flipData = Rational(data.denominator, data.numerator)
  logData = Math.log(flipData, 2).ceil
  lk.push( logData )
  
  table1.push([
    "S#{ countTable }",
    printDefaultDenominator(data, maxDenominator),
    printDefaultDenominator(sum, maxDenominator),
    "r = #{ printDefaultDenominator(sum, maxDenominator) } = (.#{ thisBinary.join("") })2",
    logData
  ])

  countTable += 1
  sum += data
end

tableP1 = Terminal::Table.new(:headings => ['Si', 'fi', 'Fi', '', 'lk'], :rows => table1, :style => {:all_separators => true} )
puts tableP1

table2 = []
upLs = {}
binaryData.each_with_index do |binary, i|

  thislk = lk[i]
  thisB = binaryData[i]

  while thislk > thisB.count
    thisB = thisB * 2
  end

  thislk -= 1

  table2.push([
    "S#{i + 1}",
    thisB[0..thislk].join("")
  ])

  if upLs[ datas[i] ].nil?
    upLs[ datas[i] ] = [0, thislk + 1]
  end

  upLs[ datas[i] ][0] += 1
end

puts ""

sumLs = 0
upLs.each_with_index do |dato, i|
  veces = dato[0]
  valor = dato[1][0]
  thislk = dato[1][1]

  sumLs += valor * veces * thislk
end

tableP2 = Terminal::Table.new(:headings => ['S', 'wj'], :rows => table2, :style => {:all_separators => true} )
puts tableP2

puts "ls => #{ sumLs }"

puts "R => #{ ( 8 / sumLs ).to_f } bits/s"

