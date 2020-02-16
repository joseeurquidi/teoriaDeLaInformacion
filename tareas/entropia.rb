require 'awesome_print'

# array = [1/36.0, 1/36.0, 1/12.0, 1/18.0, 1/9.0, 1/12.0, 1/9.0, 5/36.0, 5/36.0, 1/6.0, 1/18.0]
# base = 10

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