"""
    AbstractEBM{T} 

Supertype of all EBMs. 
"""
abstract type AbstractEBM{T} end 

"""
    AbstractZeroDEBM{T} <: AbstractEBM{T} 

Supertype of all zero dimensional EBMs. 
"""
abstract type AbstractZeroDEBM{T} <: AbstractEBM{T} end 

"""
    AbstractIncomingRadiation{T} 

Supertype of all incoming radiation / energy schemes. 
"""
abstract type AbstractIncomingRadiation{T} end 

"""
    AbstractOutgoingRadiation{T} 

Sueprtype of all outgoing radiation / engery schemes. 
"""
abstract type AbstractOutgoingRadiation{T} end 

"""
    ZeroDEBM{T} <: AbstractZeroDEBM 


# Fields 

* `R_in::AbstractIncomingRadiation`
* `R_out`::AbstractOutgoingRadiation

"""
@with_kw struct ZeroDEBM{T} <: AbstractZeroDEBM{T} 
    R_in::AbstractIncomingRadiation{T} = IncomingRadiation()
    R_out::AbstractOutgoingRadiation{T} = StefanBoltzmannRadiation()
end  

function (ebm::ZeroDEBM)(du,u,p,t)
    (; R_in, R_out) = ebm 

    du[1] = R_in(u[1], p) - R_out(u[1], p)

    nothing 
end 

@doc raw"""
    IncomingRadiation{T,F} <: AbstractIncomingRadiation 

Implements the incoming radiation given by the formula 

```math
\begin{aligned}
    R_in(T,p) = (1 - α(T,p)) \frac{S_0}{4}
\end{aligned}
```

Initialized by handing over an albedo, that is a callable function `(T,p) -> α` or one of the albedo implemented in this package like [`TanhAlbedo`](@ref).  
"""
@with_kw struct IncomingRadiation{T,F} <: AbstractIncomingRadiation{T}
    α::F=TanhAlbedo()
    S₀::T=1363.
end 

(R_in::IncomingRadiation{NF,F})(T, p=NF(0)) where {NF,F} = (1 - R_in.α(T, p))*R_in.S₀/NF(4)

@doc raw"""
    TanhAlbedo{T}

Initializes the albedo to depend on temperature with a $$tanh$$ function 

```math 
\begin{aligned}
    \alpha(T) = \alpha_0 - \frac{\alpha_1}{2} (\tanh(T - \hat{T}))
\end{aligned}
```
"""
@with_kw struct TanhAlbedo{T}
    α₀::T=0.5
    α₁::T=0.4
    T₀::T=273.
end 

(α::TanhAlbedo{NF})(T, p=NF(0)) where NF =  α.α₀ - (α.α₁/2)*tanh(T - α.T₀)

@with_kw struct PiecewiseLinearAlbedo{T}
    α_min::T = 0.25
    α_max::T = 0.6
    T_0::T = 265. 
    T_1::T = 285. 
end 

function (α::PiecewiseLinearAlbedo{NF})(T, p=NF(0)) where NF
    (; α_min, α_max, T_0, T_1) = α
    if T <= T_0
        return α_max
    elseif T >= T_1
        return α_min
    else 
        return ((α_min - α_max)/(T_1 - T_0)) * (T - T_0) + α_max
    end 
end

@doc raw"""
    StefanBoltzmannRadiation{T} <: AbstractOutgoingRadiation{T}

Implements the outgoing radiation given by the Stefan Boltzmann law, potentially reduced by a Greenhouse factor ε 

```math 
\begin{aligned}
    R_out(T) = \varepsilon\sigma T^4 
\end{aligned}
```
"""
@with_kw struct StefanBoltzmannRadiation{T} <: AbstractOutgoingRadiation{T}
    σ::T=5.67e-8
    ε::T=0.6
end 

(R_out::StefanBoltzmannRadiation{NF})(T,p=NF(0)) where NF = R_out.ε * R_out.σ * T^4

@doc raw"""
    BudykoRadiation{T} <: AbstractOutgoingRadiation{T}

Implements the outgoing radiation given by Budyko's linear approach 

```math 
\begin{aligned}
    R_out(T) = A + B\cdot T 
\end{aligned}
```

By default $$A = 202 Wm^{-2}$$ and $$B = 1.45 W m^{-2} C^{-1}$$.
"""
@with_kw struct BudykoRadiation{T} <: AbstractOutgoingRadiation{T}
    A::T=202.
    B::T=1.45
    T₀::T=273.
end 

(R_out::BudykoRadiation{NF})(T,p=NF(0)) where NF = R_out.A + R_out.B * (T - R_out.T₀)

