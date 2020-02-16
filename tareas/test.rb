require "awesome_print"

def encontrarLetra(nodo, indice, valores)

    #Ultimo nodo
    if nodo.values[0]["izquierda"].nil? && nodo.values[0]["derecha"].nil?
        return valores.push([nodo.values[0]["valor"], indice ])
    else
        if !nodo.values[0]["izquierda"].nil?
            valores = encontrarLetra(nodo.values[0]["izquierda"], indice + [0], valores)
        end
    
        if !nodo.values[0]["derecha"].nil?
            valores = encontrarLetra(nodo.values[0]["derecha"], indice + [1], valores)
        end
    end

    return valores
end

texto = "Conjunto de enunciados que componen un documento escrito."
textoOrg = texto
originalBytes = texto.unpack("B*")[0]

texto = texto.split("").select{|x| x != " " }

diccionario = Hash.new(0)
texto.each{|text| diccionario[text] += 1}
diccionario = diccionario.sort_by {|_key, value| value}

arrayArbol = {}
diccionario.each do |key, value|
    if arrayArbol[ value ].nil?
        arrayArbol[ value ] = []
    end

    arrayArbol[ value ].push( { 
        "isLetra" => true, 
        "valor" => key, 
        "derecha" => nil, 
        "izquierda" => nil 
    }  )
end

p "Prearbol"
ap arrayArbol

while true
    valueIzq = arrayArbol.keys[0]
    izquierda = arrayArbol[ valueIzq ].pop
    arrayArbol.delete_if{|k, v| v.empty? }

    valueDer = arrayArbol.keys[0]

    if arrayArbol[ valueDer ].nil?
        arrayArbol[ valueIzq ] = izquierda
        break
    end

    derecha = arrayArbol[ valueDer ].pop
    arrayArbol.delete_if{|k, v| v.empty? }

    newValue = valueIzq + valueDer

    newElement = {
        "isLetra" => false, 
        "valor" => nil, 
        "derecha" => { valueDer => derecha }, 
        "izquierda" => { valueIzq => izquierda }
    }

    if arrayArbol[ newValue ].nil?
        arrayArbol[ newValue ] = []
    end

    arrayArbol[ newValue ].push( newElement )
end

#Arbol completado

valores = encontrarLetra( arrayArbol, [], []).map{|x| [ x[0], x[1].join("")] }.to_h

bytesHoffman = []
texto.each do |letra|
    bytesHoffman.push( valores[ letra ] )
end


p "=" * 120

p "Diccionario"
ap diccionario

p "Arbol"
ap arrayArbol

p "Valores binarios"
p valores

p "Texto"
p textoOrg

p "Bytes originales"
p originalBytes

p "Bytes Hoffman"
p bytesHoffman.join("")