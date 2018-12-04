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
        @test Base.mightalias(mdiagonal, m)
        d0 = d - 1
        for k in -d0:d0
            @test diagonal(m, k) == LinearAlgebra.diag(m, k)
        end
    end
end

@testset "properties" begin
    for d in (1, 2, 3, 10)
        for T in (Int, Float64, ComplexF64)
            m = rand(T, d, d)
            dm = diagonal(m)
            @test eltype(dm) == T
            @test Base.elsize(dm) == sizeof(T)
            @test size(dm) == (d,)
            @test size(dm, 1) == d
            @test size(dm, 2) == 1
        end
    end
end

@testset "diagonal setindex!" begin
    for d in (1, 2, 3, 10)
        m = rand(d, d)
        md = diagonal(m)
        md[1] = md[1] * 2
        @test md[1] == m[1,1]
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
