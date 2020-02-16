require 'bigdecimal'
require 'awesome_print'

datos = []
puts "Introduzca unsa sesion de numeros separados por comas"
while( true )
    #[0.15, 0.22, 0.13, 0.18, 0.2, 0.12]
    datos = gets.chomp().split(",") #.split(/[\s,\,]/)
    hayLetras = !(datos.map{|x|( x =~ /[A-Za-z]/ )== 0 }.include?(true))
    datos = datos.map{|x| BigDecimal( x )} 
    hayNumerosInvalidos = !(datos.map{|x| x <= 0 || x >= 1 }.include?(true))
    sumatoriaDeNumerosNoDaUno = !(datos.inject{|sum, x| sum + x } != 1)

    if(!hayLetras)
        puts "Hay letras"
    end
    #if(!hayNumerosInvalidos)
     #   puts "Numeros Invalidos"
    #end

    #if(!sumatoriaDeNumerosNoDaUno)
     #   puts "Sumatoria de numeros no da uno"
    #end

    if  hayLetras #hayNumerosInvalidos  && && sumatoriaDeNumerosNoDaUno
        break
    end
end

#Validar que sea el formato correcto numero,numero,flotante

letra = "a"
hashDatos = {}

datos.each do |dato|
    hashDatos[ letra ] = dato
    letra = letra.next
end


datosUsuario = []
puts "Ingrese la cadena a evaluar"
while(true)
    datosUsuario = gets.chomp().downcase.split("") #"edfb".downcase.split("")
    letrasExtra = datosUsuario - hashDatos.keys

    #Validar que las letras dadas este en la tabla
    if letrasExtra.count > 0
        puts "Letras no existentes"
    else
        break
    end
end

alpha = 0
beta = 0
lamb = 0

lamb = datosUsuario.map{|x| hashDatos[ x ] }.inject{|mul, x| BigDecimal(mul) * x }

letrasAlpha = []
letrasLinea = ""
datosUsuario.count.times do |i|
    thisLetra = datosUsuario[i]
    #if i == 0
    #    letrasAlpha += ("a"..thisLetra).to_a
    #else
        if thisLetra != "a"
            letrasAlpha += ("a"..( ( thisLetra.ord - 1).chr )).to_a.map{|x| letrasLinea + x }
        end
    #end

    letrasLinea += thisLetra
end

alpha = letrasAlpha.map{|x| 
    x.split("").map{|y| 
    BigDecimal(hashDatos[y]) 
    }.inject{ |mul, f| BigDecimal(mul) * f } 
}.inject{|sum, x| BigDecimal(sum) + x }

alpha = alpha.nil? ? 0 : alpha
beta = alpha + lamb

indiceDivisor = 2.0
rota = 0
while(true)
    if 1 / indiceDivisor.to_f < lamb
        rota = 1 / indiceDivisor.to_f
        break
    else
        indiceDivisor *= 2
    end
end

indiceAlpha = ( indiceDivisor * alpha ).floor + 1
indiceBeta = ( indiceDivisor * beta ).floor
parMasMenor = indiceAlpha

(indiceAlpha..indiceBeta).to_a.each do |value|
    if value % 2 == 0
        parMasMenor = value
        break
    end
end

simplificadoX = Rational( parMasMenor, indiceDivisor )

numBin = simplificadoX.numerator * 2
denBin = simplificadoX.denominator
historialNum = []
binarioR = []
erre = []
while( true )

    if historialNum.include?( numBin )
        break
    end

    historialNum.push( numBin )
    binarioR.push([ "#{numBin}/#{denBin}", numBin >= denBin ? 1 : 0 ])

    if numBin >= denBin
        numBin = numBin % denBin
        erre.push(1)
    else
        numBin = numBin * 2
        erre.push(0)
    end
    
end

binarioA = []
binarioB = []
startA = alpha * 2
startB = beta * 2
rAlpha = []
rBeta = []

while(true)
    resA = startA >= 1 ? 1 : 0
    resB = startB >= 1 ? 1 : 0

    binarioA.push( [startA.to_s('F'), resA] )
    binarioB.push( [startB.to_s('F'), resB] )

    if resA == resB
        rAlpha.push( resA )
        rBeta.push( resB )

        if startA >= 1
            startA -= 1
        else
            startA *= 2
        end

        if startB >= 1
            startB -= 1
        else
            startB *= 2
        end

    else
        break
    end


end

puts "Tabla"
ap hashDatos
puts "Lamda => #{lamb.to_s('F')}"
puts ""
puts "Alpha => #{ alpha.to_s('F') }"
puts ""
puts "Beta => #{ beta.to_s('F') }"
puts ""
#puts "R => #{ rota }"
puts "2t => #{indiceDivisor}"
puts ""

puts "indiceAlpha => #{indiceAlpha}"
puts ""
puts "indiceBeta => #{indiceBeta}"
puts ""
puts "x => #{parMasMenor}"
puts ""
puts "simplificadoX => #{simplificadoX}"
puts ""
puts "binarioR => #{binarioR}"
puts ""
puts "r = 0.#{erre.join("")}"
puts ""
puts "binarioA => #{binarioA}"
puts ""
puts "binarioB => #{binarioB}"
puts ""
puts "rAlpha => #{rAlpha}"
puts ""
puts "rBeta => #{rBeta}"