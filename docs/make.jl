using qMRIColors
using Documenter

DocMeta.setdocmeta!(qMRIColors, :DocTestSetup, :(using qMRIColors); recursive=true)

makedocs(;
    modules=[qMRIColors],
    authors="aTrotier <a.trotier@gmail.com> and contributors",
    sitename="qMRIColors.jl",
    format=Documenter.HTML(;
        canonical="https://atrotier.github.io/qMRIColors.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Example" => "example.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/aTrotier/qMRIColors.jl",
    devbranch="main",
)
