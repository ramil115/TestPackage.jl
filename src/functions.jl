
"""
    random_pair()
Generate array of two random real numbers in [0, 1).
# Examples
```julia-repl
julia> random_pair()
[0.6563012273364509, 0.25874087765765386]
```
"""
function random_pair()
    # rand(Int, 2)
    rand(2)
end


"""
    random_fibonachi_triple()
Generate array of three consequtive Fibonacchi numbers.
# Examples
```julia-repl
julia> random_fibonachi_triple()
[6765, 10946, 17711]
```
"""
function random_fibonachi_triple()
    a, b, c = 0, 1, 1
    i = 1
    i_max = rand(1:100)
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