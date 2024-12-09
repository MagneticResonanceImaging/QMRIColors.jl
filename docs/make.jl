using QMRIColors
using Documenter

DocMeta.setdocmeta!(QMRIColors, :DocTestSetup, :(using QMRIColors); recursive=true)

makedocs(;
    modules=[QMRIColors],
    authors="aTrotier <a.trotier@gmail.com> and contributors",
    sitename="QMRIColors.jl",
    format=Documenter.HTML(;
        canonical="https://magneticresonanceimaging.github.io/QMRIColors.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "qMRI colormaps" => "colormaps.md",
        "Plot packages" => "example.md",
        "Important tips" => "clip.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/MagneticResonanceImaging/QMRIColors.jl",
    devbranch="main",
)
