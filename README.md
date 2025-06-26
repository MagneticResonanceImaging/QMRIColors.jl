# QMRIColors

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://magneticresonanceimaging.github.io/QMRIColors.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://magneticresonanceimaging.github.io/QMRIColors.jl/dev/)
[![Build Status](https://github.com/magneticresonanceimaging/QMRIColors.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/magneticresonanceimaging/QMRIColors.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/magneticresonanceimaging/QMRIColors.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/magneticresonanceimaging/QMRIColors.jl)


Julia package of https://github.com/mfuderer/colorResources

![](docs/src/assets/logo.svg)

> [!NOTE]
> <p>This package goes with the guideline paper published in Magnetic Resonance in Medicine, https://doi.org/10.1002/mrm.30290, <em> Color-map recommendation for MR relaxomtry maps </em>.</p>

<p>It is to be used to display quantitative maps of T1, R1, T2, R2, T2*, R2*, T1rho and R1rho.</p>
<p>The package contains the Lipari color map, the Navia color map as well as the logarithm-processing as referred to by the publication.</p>


<p>In essence, following commands are needed: </p>

```@example 1
# x is the image to be displayed, (loLev,upLev) is the relevant range of the values 
# we take T1 as an example
using QMRIColors
cmap,imClip = relaxationColorMap("T1",x,loLev,upLev)
VIEW(imClip,c=cmap,clim=(loLev,upLev)) 
```
> [!IMPORTANT]
> <p>In the above, "VIEW" refers to your favorite viewing software (CairoMakie, Plots, PyPlot, ...) : [see example](https://magneticresonanceimaging.github.io/QMRIColors.jl/dev/example/)</p>

<p>The relaxationColorMap() function selects the appropriate color-map (in this case, Lipari for T1) and applies logarithm-processing on that color map. The resulting colormap is returned.</p>
<p>The "imclip" image should retain the distinction between the "invalid" value of 0 (which is to be displayed as black) and "valid" values that are below loLev (these should be shown in a dark shade of blue). Depending on the calibration of your screen, you may or may not see that distinction.</p>
<p><br>A simplified processing can be done by</p>

```@example 2
using QMRIColors
cmap = relaxationColorMap("T1")
VIEW(x,c=cmap) # Do not use range limits here! 
```
<p>Again, "VIEW" refers to your favorite viewing software.</p>

## Python alternative
A python alternative is also in current development : https://github.com/oscarvanderheide/qmricolors
