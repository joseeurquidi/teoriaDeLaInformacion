require 'awesome_print'
require 'terminal-table'

def candidates(array, ll)

    salida = []
    (array * ll).permutation(ll).to_a.each do |elem|
        elem.delete_if{|y| y.nil? }

        if elem.join("").length == ll && !salida.include?( elem )
            salida.push( elem )
        end 
    end

    return salida

    # return (array * ll).permutation(ll).to_a.map{|x| 
    #     x.delete_if{|y| 
    #         y.nil? 
    #     } 
    # }.select{|x| 
    #     x.join("").length == ll 
    # }.uniq
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


totalInput = inputA + inputB
iteration = totalInput.map{|x| x.length }.max

inputA += ( [ nil ] * inputA.length )
inputB += ( [ nil ] * inputB.length )

rows = []

iteration.times do |i|
    candidatesA = candidates(inputA, i + 1 )
    candidatesB = candidates(inputB, i + 1 )
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
end

table = Terminal::Table.new( :headings => ['l', 'A', 'nA', "B", "nB"], :rows => rows, :style => {:all_separators => true} )
table.align_column(0, :right)
table.align_column(2, :center)
table.align_column(4, :center)
puts table
