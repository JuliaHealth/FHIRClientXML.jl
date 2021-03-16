@testset "Unit tests" begin
    @testset "requests.jl" begin
        @testset "_add_trailing_slash" begin
            @test FHIRClientXML._add_trailing_slash(HTTP.URI("http://julialang.org")) == HTTP.URI("http://julialang.org/")
            @test FHIRClientXML._add_trailing_slash(HTTP.URI("http://julialang.org/")) == HTTP.URI("http://julialang.org/")
        end
    end
end
