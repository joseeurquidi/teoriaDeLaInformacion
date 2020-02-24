#que no acepte letras ni caracteres que no sean numericos
# no puede tener enteros, decimales o cero
# todas las filas de la matriz tienen que ser 1
# cambiar la entrada de texto A

require 'awesome_print'
require 'bigdecimal'

rounded = 4

puts "Ingrese al arreglo A separado por comas"
a = gets.chomp.split(",").map{|x| x.to_r.to_f } #[0.4, 0.5, 0.1]
q = []

# [  [0.94, 0.04, 0.02],
# [0.01, 0.93, 0.06],
# [0.03, 0.04, 0.93] ]
a.count.times do |i|
    row_q = []
    while true
        puts "Ingrese la fila #{ i + 1} de la matriz Q separado por comas"
        row_q = gets.chomp.split(",").map{|x| x.to_r.to_f }
        if row_q.count == a.count
            break
        else
            puts "La longitud de la lista tiene que ser igual a la longitud de al arreglo A"
            puts ""
        end
    end
    q.push( row_q )
end

puts ""
puts ""
# a = a.map{|x| BigDecimal(x.to_s)}
# q = q.map{|x| x.map{|y| BigDecimal(y.to_s) } }

q2 = []
a.each_with_index do |val, i|
    q2.push( q[i].map{|x| x * val } )
end

puts "Tabla q2"
puts q2.map{|x| 
        x.map{|y| 
            y.round( rounded ) 
        } 
    }.map(&:inspect)
puts ""

pj = q2.transpose.map{|x| 
        x.inject{|sum, x| 
            sum + x 
        } 
    }


puts "Tabla PJ"
print pj.map{|x| x.round( rounded ) }

resultado = 0.0
q.each_with_index do |rowq, i|
    rowq.each_with_index do |cellq, j|

        divisor = 0.0
        a.each_with_index do |valA, k|
            divisor += valA * q[k][j] 
        end

        evalLog = cellq / divisor
        resultado += cellq * Math.log( evalLog, 2)
    end
end

puts ""
puts "Capacidad del canal #{resultado.round( rounded )}"