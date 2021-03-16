using FHIRClientXML
using Documenter

DocMeta.setdocmeta!(FHIRClientXML, :DocTestSetup, :(using FHIRClientXML); recursive=true)

makedocs(;
    modules=[FHIRClientXML],
    authors="Dilum Aluthge, Rhode Island Quality Institute, and contributors",
    repo="https://github.com/JuliaHealth/FHIRClientXML.jl/blob/{commit}{path}#{line}",
    sitename="FHIRClientXML.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaHealth.github.io/FHIRClientXML.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Installation" => "installation.md",
        "Examples" => "examples.md",
        "API" => "api.md",
    ],
    strict=true,
)

deploydocs(;
    repo="github.com/JuliaHealth/FHIRClientXML.jl",
)
