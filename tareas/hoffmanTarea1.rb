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

textoOrg = [0.15, 0.15, 0.25, 0.25, 0.20]
texto = textoOrg.sort

arrayArbol = {}
texto.each do |value|
    if arrayArbol[ value ].nil?
        arrayArbol[ value ] = []
    end

    arrayArbol[ value ].push( { 
        "isLetra" => true, 
        "valor" => value, 
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

valores = encontrarLetra( arrayArbol, [], []).map{|x| [ x[0], x[1].join("")] }
busquedaValores = valores.clone()

sigma = 1
tabla = []
textoOrg.each do |text|

  findIdx = 0
  busquedaValores.count.times do |i|
    if busquedaValores[i][0] == text
      tabla.push(["S#{sigma}", text, busquedaValores[i][1]])
      findIdx = i
      sigma += 1
      break
    end
  end

  busquedaValores.delete_at(findIdx)
end

p "=" * 120


p "Arbol"
ap arrayArbol

p "Valores binarios"
ap valores

p "tabla"
ap tabla
