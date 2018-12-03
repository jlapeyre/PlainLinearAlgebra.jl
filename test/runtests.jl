using PlainLinearAlgebra
import LinearAlgebra
using Test


@testset "diagonal" begin
    for d in (0, 1, 2, 3, 10)
        m = rand(d, d)
        mdiagonal = diagonal(m)
        mdiag = LinearAlgebra.diag(m)
        @test mdiagonal == mdiag
        @test sum(mdiagonal) ≈ sum(mdiag)
    end
end

@testset "identity matrix" begin
    for d in (0, 1, 2, 3, 10)
        @test idmat(d) == idmat(Float64, d)
        for T in (Int, Rational{Int})
            @test isa(idmat(T, d), Matrix{T})
        end
    end
end
