```@meta
CurrentModule = Exercise8
```

# Exercise8

Documentation for [Exercise8](https://github.com/maximilian-gelbrecht/Exercise8.jl). This package implements the zero-dimensional energy balance models (EBMs) introduced in the lecture. The models are coded so that different 0D-EBMs can be easily composed. E.g. via 

```julia 
using Exercise8, OrdinaryDiffEq

model = ZeroDEBM(R_in=IncomingRadiation(α=TanhAlbedo()), R_out=StefanBoltzmannRadiation()) 

prob = ODEProblem(model, 270., (0.,4.), [])
sol = solve(prob, Tsit5())
```
 
```@index
```

```@autodocs
Modules = [Exercise8]
```
