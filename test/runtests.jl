using FHIRClientXML
using Test

import BSON
import BrokenRecord
import HTTP
import XMLDict

@testset "FHIRClientXML.jl" begin
    include("unit-tests.jl")
    include("recorded-tests.jl")
end
