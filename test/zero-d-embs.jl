
@testset "Albedo Tests" begin 
    α = TanhAlbedo()
    @test α(220) ≈ 0.7 
    @test α(320) ≈ 0.3

    α = PiecewiseLinearAlbedo()
    @test α(220) ≈ α.α_max
    @test α(320) ≈ α.α_min
end 

@testset "Boltzmann Model Fixed Points" begin 
    model = ZeroDEBM(R_in=IncomingRadiation(α=TanhAlbedo()), R_out=StefanBoltzmannRadiation()) 
    prob = ODEProblem(model, [220.], (0.,4.), [])

    sol_low = solve(prob, Tsit5())
    @test 230. < sol_low[end][1] < 238.

    sol_high = solve(remake(prob, u0=[320]), Tsit5())
    @test 286. < sol_high[end][1] < 295.
end 

@testset "Budyko Model Fixed Points" begin 
    model = ZeroDEBM(R_in=IncomingRadiation(α=TanhAlbedo()), R_out=BudykoRadiation()) 
    prob = ODEProblem(model, [220.], (0.,4.), [])

    sol_low = solve(prob, Tsit5())
    @test 200. < sol_low[end][1] < 208.

    sol_high = solve(remake(prob, u0=[320]), Tsit5())
    @test 295. < sol_high[end][1] < 305.
end 

