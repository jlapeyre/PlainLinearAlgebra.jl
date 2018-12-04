# PlainLinearAlgebra

[![Build Status](https://travis-ci.com/jlapeyre/PlainLinearAlgebra.jl.svg?branch=master)](https://travis-ci.com/jlapeyre/PlainLinearAlgebra.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/jlapeyre/PlainLinearAlgebra.jl?svg=true)](https://ci.appveyor.com/project/jlapeyre/PlainLinearAlgebra-jl)
[![Codecov](https://codecov.io/gh/jlapeyre/PlainLinearAlgebra.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/jlapeyre/PlainLinearAlgebra.jl)
[![Coveralls](https://coveralls.io/repos/github/jlapeyre/PlainLinearAlgebra.jl/badge.svg?branch=master)](https://coveralls.io/github/jlapeyre/PlainLinearAlgebra.jl?branch=master)

This module collects a few linear algebra (related) functions
that are not yet in a package or the Julia standard library

### diagonal

    diagonal(M::AbstractMatrix, k = 0)

An iterator over the `k`th diagonal of `M`.

`collect(diagonal(M))` is equivalent to `diag(m)`.

### idmat

    idmat([::Type{T},] n::Integer)

Return an `n` x `n` identity matrix of type `Matrix{T}`.

`idmat` is not called `eye` because it's not clear when and where `eye` might be resurrected, and what it will do.
You should be aware of `Eye` in [FillArrays.jl](https://github.com/JuliaArrays/FillArrays.jl)
