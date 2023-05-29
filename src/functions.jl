function random_pair()
    # rand(Int, 2)
    rand(2)
    # rand(1:10)
end

function random_fibonachi_triple()
    a, b, c = 0, 1, 1
    i = 1
    i_max = rand(1:10)
    while i<i_max
        # println(a,' ',b, ' ',c)
        a = b
        b = c
        c = a+b
        i += 1        
    end
    return [a,b,c]
end

export random_pair, random_fibonachi_triple