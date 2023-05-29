using TestPackage
using Test

@testset "TestPackage.jl" begin
    @test length(TestPackage.random_pair()) == 2
    @test length(TestPackage.random_fibonachi_triple()) == 3
    fib_out = TestPackage.random_fibonachi_triple()
    @test fib_out[1]+fib_out[2] == fib_out[3]
end
