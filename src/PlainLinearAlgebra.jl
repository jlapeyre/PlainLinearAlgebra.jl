module PlainLinearAlgebra

using LinearAlgebra: I, checksquare

import Base: iterate, elsize, size, getindex, setindex!, parent

export idmat, diagonal, DiagonalIterator

### DiagonalIterator

abstract type AbstractDiagonalIterator{T, V}  <: AbstractVector{T} end

"""
    DiagonalIterator{T <: AbstractMatrix}

Iterator over the diagonal of an AbstractMatrix
"""
struct DiagonalIterator{T, V <:AbstractMatrix} <: AbstractDiagonalIterator{T, V}
    M::V
    length::Int
end

"""
    diagonal(M::AbstractMatrix)

Return an iterator over the diagonal of `M`.

`collect(diagonal(M))` is equivalent to `diag(m)`. But, because
no allocation is done, `diagonal` can be faster. For example,
`sum(diagonal(M))` is faster than `sum(diag(m))`.

`diagonal` is efficient for types that support efficient cartesian indexing.
"""
diagonal(M::V) where V <: AbstractMatrix  = DiagonalIterator{eltype(M), V}(M, checksquare(M))

iterate(iter::DiagonalIterator, i = 1) = i > iter.length ? nothing : (iter.M[i,i], i + 1)
size(iter::DiagonalIterator) = (iter.length,)
elsize(::Type{DiagonalIterator{T, V}}) where {T, V} = sizeof(T)
getindex(iter::DiagonalIterator, i) = iter.M[i,i]
setindex!(iter::DiagonalIterator, v, i) = (iter.M[i,i] = v)
parent(iter::DiagonalIterator) = iter.M
Base.dataids(d::DiagonalIterator) = Base.dataids(parent(d))


### idmat

"""
    idmat([::Type{T},] n::Integer)

Return an `n` x `n` identity matrix of type `Matrix{T}`.
"""
idmat(::Type{T}, n::Integer) where T = Matrix{T}(I, n, n)
idmat(n::Integer) = idmat(Float64, n)
idmat(::Type{T}, m::AbstractMatrix) where T = idmat(T, checksquare(m))
idmat(m::AbstractMatrix) = idmat(eltype(m), m)

end # module
