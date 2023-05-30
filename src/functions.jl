
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
    a, b = BigInt(1), BigInt(1)
    k = 1
    m = 1
    result = []
    while m <= array_number
        for sequence_length in sequence_length_array
            sequence = Array{BigInt}(undef, 0)
            j = 1
            while j <= sequence_length
                if !get_even || (get_even && iseven(k))
                    push!(sequence, a)
                    j += 1
                end
                a_old = a
                a = b
                b = a_old + a
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

export random_pair, fibonacci_sequence

# fib(n::Integer) = n ≤ 2 ? one(n) : fib(n-1) + fib(n-2)