using FHIRClientXML
using Test

import HTTP
import XMLDict

@testset "FHIRClientXML.jl" begin
    @test FHIRClientXML.f(1) == 2
end
