#Cuantos eventos estan participando
#cambiar mensajes de entrada
#que no acepte caracteres, ni numeros, ni negativos, solo fracciones y decimales

require 'awesome_print'


puts "Ingrese los datos separados por comas"
array = gets.chomp.split(",").map{|x| x.to_r.to_f }
puts "Ingrese la base"
base = gets.chomp.to_i

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
puts "Informacion mutua: #{ iE }"
puts "Entropia: #{hE}"

