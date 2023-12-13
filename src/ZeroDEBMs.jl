module ZeroDEBMs

using Parameters 

include("zero-d-embs.jl")

export ZeroDEBM 
export IncomingRadiation, TanhAlbedo, PiecewiseLinearAlbedo
export StefanBoltzmannRadiation, BudykoRadiation

end
