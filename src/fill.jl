using FillArrays: Zeros
using LinearAlgebra: Diagonal, Bidiagonal, SymTridiagonal

const Diagonals = Union{Diagonal{T}, Bidiagonal{T}, SymTridiagonal{T}} where T
const BiTriDiagonals = Union{Bidiagonal, SymTridiagonal}

_main_diagonal(D::Diagonal) = D.diag
_main_diagonal(M::Bidiagonal) = M.dv
_main_diagonal(M::SymTridiagonal) = M.dv

superdiagonal(M::Diagonal) = _offdiagonal_Zeros(M, 1)
subdiagonal(M::Diagonal) = _offdiagonal_Zeros(M, 1)

superdiagonal(M::SymTridiagonal) = _super_sub_diagonal_data(M)
subdiagonal(M::SymTridiagonal) = _super_sub_diagonal_data(M)

superdiagonal(M::Bidiagonal) = _superdiagonal(M, Val(M.uplo))
subdiagonal(M::Bidiagonal) = _subdiagonal(M, Val(M.uplo))

_superdiagonal(M::Bidiagonal, ::Val{'U'}) = _super_sub_diagonal_data(M)
_superdiagonal(M::Bidiagonal, ::Val{'L'}) = _offdiagonal_Zeros(M, 1)
_subdiagonal(M::Bidiagonal, ::Val{'L'}) = _super_sub_diagonal_data(M)
_subdiagonal(M::Bidiagonal, ::Val{'U'}) = _offdiagonal_Zeros(M, 1)

_super_sub_diagonal_data(M::BiTriDiagonals) = M.ev

"""
    _offdiagonal_Zeros(M::AbstractMatrix{T}, k)

Return a `Zeros` array representing the `k`th offdiagonal, regardless
of whether the `k`th offdiagonal of `M` is zeros or not.
"""
_offdiagonal_Zeros(::Type{T}, diaglen::Integer, k::Integer) where T = Zeros{T}(max(diaglen - abs(k), 0))
_offdiagonal_Zeros(M::AbstractMatrix{T}, k) where T = _offdiagonal_Zeros(T, size(M, 1), k)

function diagonal(D::Diagonals, k::Integer=0)
    k == 0 && return _main_diagonal(D)
    return offdiagonal(D, k)
end

"""
    offdiagonal(M, k)

`k`th diagonal of `M` for `abs(k) ≥ 2`.
"""
function offdiagonal end

offdiagonal(D::Diagonal, k) = _offdiagonal_Zeros(D, k)
function offdiagonal(D::BiTriDiagonals, k)
    k = 1 && return superdiagonal(D)
    k = -1 && return subdiagonal(D)
    return _offdiagonal_Zeros(D, k)
end
