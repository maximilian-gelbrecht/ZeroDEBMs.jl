```@meta
CurrentModule = ZeroDEBMs
```

# Exercise8

Documentation for [ZeroDEBMs](https://github.com/maximilian-gelbrecht/ZeroDEBMs.jl). This package implements the zero-dimensional energy balance models (EBMs) introduced in the lecture. The models are coded so that different 0D-EBMs can be easily composed. E.g. via 

```julia 
using ZeroDEBMs, OrdinaryDiffEq

model = ZeroDEBM(R_in=IncomingRadiation(α=TanhAlbedo()), R_out=StefanBoltzmannRadiation()) 

prob = ODEProblem(model, 270., (0.,4.), [])
sol = solve(prob, Tsit5())
```
 
```@index
```

```@autodocs
Modules = [ZeroDEBMs]
```
