using QuantitativeMRIColors
using Colors
using Test

@testset "QuantitativeMRIColors.jl" begin

    @testset "colormap" begin
    # T1 test
    cmap = relaxationColorMap("T1")
    @test cmap[1] == RGB(0.0,0.0,0.0)
    @test cmap[2] == RGB(0.017234, 0.090035, 0.169728)
    @test cmap[end] == RGB(0.992307, 0.959017, 0.856609)

    # T2 test
    cmap = relaxationColorMap("T2")
    @test cmap[1] == RGB(0.0,0.0,0.0)
    @test cmap[2] ==RGB(0.016803, 0.089716, 0.174205)
    @test cmap[end] == RGB(0.986688, 0.958281, 0.850479)

    # Reverse map R1
    cmap = relaxationColorMap("R1")
    @test cmap[1] == RGB(0.0,0.0,0.0)
    @test cmap[2] == RGB(0.982484, 0.940402, 0.830308)
    @test cmap[end] == RGB(0.01137, 0.07324, 0.148284)

    end

    
end
