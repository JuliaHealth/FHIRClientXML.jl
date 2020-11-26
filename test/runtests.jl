using FHIRClientXML
using Test

@testset "FHIRClientXML.jl" begin
    @test FHIRClientXML.f(1) == 2
end
