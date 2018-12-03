module PlainLinearAlgebra

using LinearAlgebra: I, checksquare

import LinearAlgebra: iterate

import Base: length, size, eltype, getindex, setindex!, firstindex, lastindex,
       parent

export idmat, diagonal, DiagonalIterator

### DiagonalIterator

abstract type AbstractDiagonalIterator end

"""
    DiagonalIterator{T <: AbstractMatrix}

Iterator over the diagonal of an AbstractMatrix
"""
struct DiagonalIterator{T <: AbstractMatrix} <: AbstractDiagonalIterator
    M::T
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
diagonal(M::T) where T <: AbstractMatrix  = DiagonalIterator(M, checksquare(M))

function iterate(iter::DiagonalIterator, i = 1)
    return i > iter.length ? nothing : (iter.M[i,i], i + 1)
end
length(iter::DiagonalIterator) = iter.length
size(iter::DiagonalIterator, dim=1) = (iter.length,)
eltype(iter::DiagonalIterator) = eltype(iter.M)
getindex(iter::DiagonalIterator, i) = iter.M[i,i]
setindex!(iter::DiagonalIterator, v, i) = (M[i,i] = v)
firstindex(iter::DiagonalIterator) = 1 # This may not be general enough
lastindex(iter::DiagonalIterator) = iter.length
parent(iter::DiagonalIterator) = iter.M

# This was not inlined into the subsequent one-line function, causing a performance loss
@inline function (Base.:(==))(AV::AbstractVector, DI::DiagonalIterator)
    length(AV) == length(DI) || return false
    for i in 1:length(AV)
        AV[i] == DI[i] || return false
    end
    return true
end
(Base.:(==))(DI::DiagonalIterator, AV::AbstractVector) = AV == DI

### idmat

"""
    idmat([::Type{T},] n::Integer)

Return an `n` x `n` identity matrix of type `Matrix{T}`.
"""
idmat(::Type{T}, n::Integer) where T = Matrix{T}(I, n, n)
idmat(n::Integer) = idmat(Float64, n)

end # module
