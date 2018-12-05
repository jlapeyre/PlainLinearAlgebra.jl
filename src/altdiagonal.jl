import Base: iterate, elsize, size, getindex, setindex!, parent

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
    altdiagonal(M::AbstractMatrix)


An iterator over the diagonal of `M`. `altdiagonal` is an alternative
to the iterator `diagonal`.  An iterator is constructed much more quickly
with `altdiagonal` than with `diagonal`.
"""
altdiagonal(M::V) where V <: AbstractMatrix  = DiagonalIterator{eltype(M), V}(M, checksquare(M))

iterate(iter::DiagonalIterator, i = 1) = i > iter.length ? nothing : (iter.M[i,i], i + 1)
size(iter::DiagonalIterator) = (iter.length,)
elsize(::Type{DiagonalIterator{T, V}}) where {T, V} = sizeof(T)
getindex(iter::DiagonalIterator, i) = iter.M[i,i]
setindex!(iter::DiagonalIterator, v, i) = (iter.M[i,i] = v)
parent(iter::DiagonalIterator) = iter.M
Base.dataids(d::DiagonalIterator) = Base.dataids(parent(d))
