"""
    module PlainLinearAlgebra

Some linear-algebra-related functions.

### Functions: `diagonal`, `idmat`
"""
module PlainLinearAlgebra

using LinearAlgebra: I, checksquare, diagind

export idmat, diagonal

### diagonal

# See Julia issue #30250
"""
    diagonal(M::AbstractMatrix, k::Integer=0)

An iterator over the `k`th diagonal of `M`.

`collect(diagonal(M))` is equivalent to `diag(m)`.

# Examples
```jldoctest
julia> A = [1 2 3; 4 5 6; 7 8 9]
3×3 Array{Int64,2}:
 1  2  3
 4  5  6
 7  8  9

julia> dA = diagonal(A, 1)
2-element view(::Array{Int64,1}, 4:4:8) with eltype Int64:
 2
 6

julia> dA[1] = 1
1

julia> A
3×3 Array{Int64,2}:
 1  1  3
 4  5  6
 7  8  9
```
"""
diagonal(A::AbstractMatrix, k::Integer=0) = view(A, diagind(A, k))

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
