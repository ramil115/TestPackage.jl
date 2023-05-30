using TestPackage
using Test

@testset "TestPackage.jl" begin
    @test length(TestPackage.random_pair()) == 2
    @test isreal(random_pair()) == true
    @test TestPackage.fibonacci_sequence([3],20, true)[end] == BigInt[781774079430987230203437, 2046711111473984623691759, 5358359254990966640871840]
    @test TestPackage.fibonacci_sequence([3],20)[end] == BigInt[591286729879, 956722026041, 1548008755920]
end
