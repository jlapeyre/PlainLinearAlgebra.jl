# PlainLinearAlgebra

[![Build Status](https://travis-ci.com/jlapeyre/PlainLinearAlgebra.jl.svg?branch=master)](https://travis-ci.com/jlapeyre/PlainLinearAlgebra.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jlapeyre/PlainLinearAlgebra.jl?svg=true)](https://ci.appveyor.com/project/jlapeyre/PlainLinearAlgebra-jl)
[![Codecov](https://codecov.io/gh/jlapeyre/PlainLinearAlgebra.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jlapeyre/PlainLinearAlgebra.jl)
[![Coveralls](https://coveralls.io/repos/github/jlapeyre/PlainLinearAlgebra.jl/badge.svg?branch=master)](https://coveralls.io/github/jlapeyre/PlainLinearAlgebra.jl?branch=master)

This module collects a few linear algebra (related) functions that are not yet in a package or the Julia
standard library

### diagonal

    diagonal(M::AbstractMatrix)

Return an iterator over the diagonal of `M`.

`collect(diagonal(M))` is equivalent to `diag(m)`. But, because
no allocation is done, `diagonal` can be faster. For example,
`sum(diagonal(M))` is faster than `sum(diag(m))`.

`diagonal` is efficient for types that support efficient cartesian indexing.

#### Note

Alex Arslan suggested
```
diagonal(A::AbstractMatrix, k::Integer=0) = view(A, diagind(A, k)),
```
which is probably just as efficient as the implementation here.

### idmat

    idmat([::Type{T},] n::Integer)

Return an `n` x `n` identity matrix of type `Matrix{T}`.

`idmat` is not called `eye` because it's not clear when and where `eye` might be resurrected, and what it will do.
But, you should be aware that there exists `Eye` in [FillArrays.jl](https://github.com/JuliaArrays/FillArrays.jl)
