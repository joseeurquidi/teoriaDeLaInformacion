# no puede haber caracteres repetidos

require 'awesome_print'
require 'terminal-table'

def candidates(array, ll, old_data)

    salida = []
    evalsData = array.permutation(ll).to_a
    evalsData += old_data
    array.each do |dat|
        old_data.each do |odat|
            evalsData += [(odat + [dat])]
        end
    end



    evalsData.each do |elem|
        #elem.delete_if{|y| y.nil? }

        if elem.join("").length == ll
            salida.push( elem )
        end 
    end

    salida.uniq!
    return salida, evalsData
  
end

while true
    puts "Ingrese alfabeto de entrada (separando los elementos por comas)"
    inputA = gets.chomp.split(",") #[ 0, 1, 22 ]
    puts "Ingrese alfabeto de salida (separando los elementos por comas)"
    inputB = gets.chomp.split(",") #[ 0, 3, 444, 5555 ]

    print inputA
    puts ""
    print inputB
    puts ""
    puts ""

    puts "Es correcta la entrada de datos? (s/n)"
    salida = gets.chomp.downcase
    if salida == "s"
        break
    end
end



start = Time.now
totalInput = inputA + inputB
iteration = totalInput.map{|x| x.length }.max
iteration = 8
old_dataA = []
old_dataB = []

rows = []
rowsTotalsOnly = []

iteration.times do |i|
    candidatesA, old_dataA = candidates(inputA, i + 1, old_dataA )
    candidatesB, old_dataB = candidates(inputB, i + 1, old_dataB )
    new_row = []
    new_row.push( i + 1)
    new_row.push( candidatesA.map{|x| 
                        x.join(",") 
                    }.join("\n") )
    new_row.push( candidatesA.count )

    new_row.push( candidatesB.map{|x| 
                        x.join(",") 
                    }.join("\n") )
    new_row.push( candidatesB.count )
    rows.push( new_row )
    
    new_row = []
    new_row.push( i + 1)
    new_row.push( candidatesA.count )
    new_row.push( candidatesB.count )
    rowsTotalsOnly.push( new_row )
end

table = Terminal::Table.new( :headings => ['l', 'A', 'nA', "B", "nB"], :rows => rows, :style => {:all_separators => true} )
table.align_column(0, :right)
table.align_column(2, :center)
table.align_column(4, :center)
puts table

puts ""
puts ""

tablePre = Terminal::Table.new( :headings => ['l', 'nA', "nB"], :rows => rowsTotalsOnly, :style => {:all_separators => true} )
tablePre.align_column(0, :right)
tablePre.align_column(1, :center)
tablePre.align_column(2, :center)
puts tablePre

puts ""

p "Time #{ Time.now - start }"