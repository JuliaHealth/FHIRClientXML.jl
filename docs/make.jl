using FHIRClientXML
using Documenter

makedocs(;
    modules=[FHIRClientXML],
    authors="Dilum Aluthge, Rhode Island Quality Institute, contributors",
    repo="https://github.com/JuliaHealth/FHIRClientXML.jl/blob/{commit}{path}#L{line}",
    sitename="FHIRClientXML.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaHealth.github.io/FHIRClientXML.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/JuliaHealth/FHIRClientXML.jl",
)
