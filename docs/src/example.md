# Example

The generated colormap can be easily integrated with multiple plotting library like :
- Makie.jl (recommended)
- Plots.jl
- PythonPlot.jl / PyPlot.jl

# Makie.jl

For `Makie.jl` the colormap can be directly used like `heatmap(x,colormap=cmap,colorrange=(loLev,upLev))`

```@example 2
using qMRIColors
using CairoMakie

# -----  Make test object: gradually increasing T1, but invalid outside a circle
size = 256; center = size÷2+1; radius = 100; origin = CartesianIndex(center,center)
d(x::CartesianIndex, y::CartesianIndex) = √( (x[1]-y[1])^2 + (x[2]-y[2])^2 )
row = [10*i for i in 1:size]
testT1= zeros(size,size)
testT1 .= row

# Set invalid values to 0
allidx = CartesianIndices(testT1)
invalid = allidx[ d.(origin, allidx) .> radius];
testT1[invalid] .= 0
# ---------------------------------------------- Test object made

# -------------------- Display test object the correct and the wrong way
loLev = 700
upLev = 2000
begin
  f=CairoMakie.Figure()
  ax=Axis(f[1,1],aspect = DataAspect(),title = "Using imClip")
  cmap,imClip = relaxationColorMap("T1",testT1,loLev,upLev)
  h=heatmap!(ax,rotr90(imClip),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[1,2],h)
  hidedecorations!(ax)

  ax=Axis(f[2,1],aspect = DataAspect(),title = "wrong: simplified, \n with range")
  cmap = relaxationColorMap("T1")
  h=heatmap!(ax,rotr90(testT1),colormap=cmap,colorrange=(loLev,upLev))
  Colorbar(f[2,2],h)
  hidedecorations!(ax)

  ax=Axis(f[3,1],aspect = DataAspect(),title = "OK: simplified, \n no range")
  cmap = relaxationColorMap("T1")
  h=heatmap!(ax,rotr90(testT1),colormap=cmap)
  Colorbar(f[3,2],h)
  hidedecorations!(ax)

  # clean up plot
  colsize!(f.layout, 1, Aspect(1,1))
  resize_to_layout!(f)
  f
end
```


# Plots.jl

Using GR backend
```@example 3
using FileIO
using Downloads
using qMRIColors
using CairoMakie

url = "https://github.com/mfuderer/colorResources/raw/refs/heads/main/sampleT1map.jld"
dest_path = "sampleT1map.jld"
# Download the file
Downloads.download(url, dest_path)
x = FileIO.load("sampleT1map.jld")["sampleT1map"]

loLev = 700
upLev = 1500
cmap,imClip = relaxationColorMap("T1",x,loLev,upLev)

using Plots #GR backend
gr(size=(400,300))
p = Plots.heatmap(imClip,
            c=cmap,
            clim=(loLev,upLev),
            yflip=true
            )
```

# PythonPlot.jl / PyPlot.jl
The colormap needs to be converted to a usable format with the following command : `cmap_py = PythonPlot.ColorMap("relaxationColor", cmap, length(cmap), 1.0)` 

```@example 4
using FileIO
using qMRIColors

x = FileIO.load("sampleT1map.jld")["sampleT1map"]

loLev = 700
upLev = 1500
cmap,imClip = relaxationColorMap("T1",x,loLev,upLev)

using PythonPlot
cmap_py = PythonPlot.ColorMap("relaxationColor", cmap, length(cmap), 1.0) # translating the colormap to a format digestible by PythonPlot

figure()
imshow(imClip, vmin=loLev, vmax =upLev, interpolation="bicubic", cmap=cmap_py)
colorbar()
PythonPlot.savefig("plot.png")
```
![](plot.png)