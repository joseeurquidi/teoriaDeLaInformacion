
# x que no acepte caracteres, ni numeros, ni negativos, solo fracciones y decimales

require 'awesome_print'


while true
    puts "=" * 30
    puts "Ingrese los datos separados por comas"
    array = gets.chomp.split(",") #.map{|x| x.to_r }
    
    datosAceptables = true
    puts ""
    array.each do |arr|
      if arr.to_r <= 0 || arr.to_r % 1 == 0
        datosAceptables = false
        puts "El valor #{ arr } no es valido"
      end
    end

    if !datosAceptables
      puts ""  
    end

    # datosAceptables = !array.empty?
    if array.empty?
      datosAceptables = false
      puts "Entrada de datos vacia"
      puts ""
    end

    array = array.map{|x| x.to_r }

    if datosAceptables        
        break
    else
        puts "DATOS INCORRECTOS"
        puts ""
    end
end

array = array.map{|x| x.to_f }

puts "=" * 30
while true
  puts "Ingrese la base de logaritmo: "
  base = gets.chomp.to_i
  if base > 0
    break
  else
    puts "DATOS INCORRECTOS"
    puts ""
  end
end


iE = array.map{|x| Math.log(x, base) }.inject{|sum,x| sum + x } * -1

hashArray = {}
array.each do |e|
    if hashArray[ e ].nil?
        hashArray[ e ] = 0
    end

    hashArray[ e ] += 1
end


hE = 0.0
hashArray.each do |k, v|
    hE += (v * k) * Math.log(k, base)
end
hE *= -1

puts ""
puts "Datos otorgados #{ array }"
puts "Logaritmo Base #{ base }"
puts "Informacion mutua: #{ iE }"
puts "Entropia: #{hE}"

