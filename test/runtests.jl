using TestPackage
using Test

@testset "TestPackage.jl" begin
    @test length(TestPackage.random_pair()) == 2
    @test isreal(random_pair()) == true
    fib_out = TestPackage.random_fibonachi_triple()
    @test isreal(fib_out) == true
    @test length(fib_out) == 3    
    @test fib_out[1]+fib_out[2] == fib_out[3]
end
