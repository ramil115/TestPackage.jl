using TestPackage
using Test

@testset "TestPackage.jl" begin
    @test length(TestPackage.random_pair()) == 2
    @test isreal(random_pair()) == true
    @test length(TestPackage.get_next_fib_seq(5,"even")) == 5
    @test TestPackage.get_next_fib_seq(100,"odd")[end] > 0
    seq = get_next_fib_seq(rand(1:100))
    @test seq[end-2]+seq[end-1] == seq[end]
end
