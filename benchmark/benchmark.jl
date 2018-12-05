using BenchmarkTools
using PlainLinearAlgebra
import PlainLinearAlgebra: diagonal, altdiagonal

using LinearAlgebra: diag

BenchmarkTools.DEFAULT_PARAMETERS.overhead = BenchmarkTools.estimate_overhead()

const SUITE = BenchmarkGroup()

function compactstring(fun)
    io = IOBuffer()
    print(IOContext(io, :compact => true), fun)
    return String(take!(io))
end

###
### diagonal
###

g = addgroup!(SUITE, "diagonal", [])

m2 = rand(2, 2)
m10 = rand(10, 10)
m1000 = rand(1000, 1000)

r1 = addgroup!(g, "reduction", [])

dimstring(a) = string("n=", size(a, 1))
funop(fun, op) = string(compactstring(fun),"(", compactstring(op), "(a))")

for a in (m2, m10, m1000)
    for fun in (sum, prod)
        for diagfun in (diag, diagonal, altdiagonal)
            r1[funop(fun, diagfun), string(eltype(a)), dimstring(a)] = @benchmarkable $fun($diagfun($a))
        end
    end
end

# If a cache of tuned parameters already exists, use it, otherwise, tune and cache
# the benchmark parameters. Reusing cached parameters is faster and more reliable
# than re-tuning `SUITE` every time the file is included.
paramspath = joinpath(dirname(@__FILE__), "params.json")

if isfile(paramspath)
    loadparams!(SUITE, BenchmarkTools.load(paramspath)[1], :evals);
else
    tune!(SUITE)
    BenchmarkTools.save(paramspath, params(SUITE));
end

result = run(SUITE, verbose = true)
