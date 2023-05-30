
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
    fibonacci_sequence(sequence_length_array::Array{Int}, number_of_cycles::Integer, get_even::Bool)
Generate arrays of consequtive Fibonacci numbers.
# Arguments
- `sequence_length_array::Array{Int}`: array of desired sequence lengths. Default value is [3].
- `array_number::Integer`: total number of output sequences. Default value is 5.
- `get_even::Bool`: set True if even members of Fibonacci series needed. Default value is False.
```julia-repl
julia> fibonacci_sequence()
5-element Vector{Any}:
 BigInt[1, 1, 2]
 BigInt[3, 5, 8]
 BigInt[13, 21, 34]
 BigInt[55, 89, 144]
 BigInt[233, 377, 610]

julia> fibonacci_sequence([2], 3, true)
3-element Vector{Any}:
 BigInt[1, 3]
 BigInt[8, 21]
 BigInt[55, 144]

julia> fibonacci_sequence([2,3], 4)
4-element Vector{Any}:
 BigInt[1, 1]
 BigInt[2, 3, 5]
 BigInt[8, 13]
 BigInt[21, 34, 55]

```
"""
function fibonacci_sequence(sequence_length_array::Array{Int} = [3], array_number::Integer = 5, get_even::Bool= false)
    a, b = 1, 1
    k = 1
    m = 1
    result = []
    flag  = true
    while m <= array_number
        for sequence_length in sequence_length_array
            sequence = []
            j = 1
            while j <= sequence_length
                if !get_even || (get_even && iseven(k))
                    push!(sequence, a)
                    j += 1
                end
                a_old = a
                a = b
                if a_old + a < 0 && flag
                    b = BigInt(a_old) + BigInt(a)
                    flag = false
                else
                    b = a_old + a
                end

                k += 1
            end
            # println(sequence)
            push!(result, sequence)
            m += 1
            if m > array_number
                break
            end
        end
    end
    return result
end

# Fibonacci sequence struct with a, b being sequence numbers and k is index of a
mutable struct Fib
    a
    b
    k
end

global fib = Fib(1,1,1)

"""
get_next_fib_seq(length::Int64, type::String)
Generate array of next consequtive Fibonacci numbers.
# Arguments
- `length::Int64`: array length. Default value is [3].
- `type::String`: set "even", "odd" or "all". Default value is "all".
```julia-repl
julia> get_next_fib_seq()
3-element Vector{Any}:
 13
 21
 34

julia> get_next_fib_seq(4,"even")
4-element Vector{Any}:
   55
  144
  377
  987

```
"""
function get_next_fib_seq(length::Int64 = 3, type::String = "all")
    if type!="all"&&type!="even"&&type!="odd"
        throw(ArgumentError("Type argument must be one of the {'all', 'even', 'odd'}."))
    end
    out = []
    i = 1
    while i <= length
        if (type == "even" && iseven(fib.k))||(type == "odd" && isodd(fib.k))||type == "all"
            push!(out, fib.a)
            i += 1
        end
        if fib.a + fib.b < 0 
            fib.a = BigInt(fib.a)
            fib.b = BigInt(fib.b)
        end
        a_old = fib.a
        fib.a = fib.b
        fib.b = a_old + fib.a
        fib.k += 1
    end
    return out
end

export random_pair, fibonacci_sequence, get_next_fib_seq

# fib(n::Integer) = n ≤ 2 ? one(n) : fib(n-1) + fib(n-2)