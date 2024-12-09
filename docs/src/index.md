```@meta
CurrentModule = QMRIColors
```

Documentation for [QMRIColors](https://github.com/magneticresonanceimaging/QMRIColors.jl).

# Introduction

This package goes with the guideline paper published in Magnetic Resonance in Medicine: [https://doi.org/10.1002/mrm.30290](https://doi.org/10.1002/mrm.30290), Color-map recommendation for MR relaxomtry maps.

It is to be used to display quantitative maps of T1, R1, T2, R2, T2*, R2*, T1rho and R1rho.

!!! note
    The initial Julia implementation is available [here](https://github.com/mfuderer/colorResources)

The package contains multiple [qMRI colormaps](@ref) :
- Lipari color map
- Navia color map 

!!! tip
    In addition the code also provides access to the logarithm-processing as referred to by the publication. Take a look at [Important tips](@ref) for more information

The color maps are compatible with various [Plot packages](@ref) :
- Makie.jl
- Plots.jl
- PythonPlot.jl / PyPlot.jl


