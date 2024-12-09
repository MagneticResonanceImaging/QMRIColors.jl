using QuantitativeMRIColors
using Documenter

DocMeta.setdocmeta!(QuantitativeMRIColors, :DocTestSetup, :(using QuantitativeMRIColors); recursive=true)

makedocs(;
    modules=[QuantitativeMRIColors],
    authors="aTrotier <a.trotier@gmail.com> and contributors",
    sitename="QuantitativeMRIColors.jl",
    format=Documenter.HTML(;
        canonical="https://magneticresonanceimaging.github.io/QuantitativeMRIColors.jl",
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
    repo="github.com/MagneticResonanceImaging/QuantitativeMRIColors.jl",
    devbranch="main",
)
