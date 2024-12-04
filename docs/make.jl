using qMRIColors
using Documenter

DocMeta.setdocmeta!(qMRIColors, :DocTestSetup, :(using qMRIColors); recursive=true)

makedocs(;
    modules=[qMRIColors],
    authors="aTrotier <a.trotier@gmail.com> and contributors",
    sitename="qMRIColors.jl",
    format=Documenter.HTML(;
        canonical="https://magneticresonanceimaging.github.io/qMRIColors.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "qMRI colormaps" => "colormaps.md",
        "Plot packages" => "example.md",
        "Important Tips" => "clip.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/magneticresonanceimaging/qMRIColors.jl",
    devbranch="main",
)
